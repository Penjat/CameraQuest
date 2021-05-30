import Combine
import AVKit

class SimpleCameraModel: ObservableObject {
    @Published var gameState: SimpleCameraState = .loading
    
    private let cameraService = CameraService()
    private let mlService = ImageScanner()
    private var bag = Set<AnyCancellable>()
    var session: AVCaptureSession {
        cameraService.session
    }
    
    init() {
        cameraService.checkForPermissions()
        cameraService.configure()
        
        intents
        .sink { intent in
            switch intent {
            case .pressedButton:
                switch self.gameState {
                case .ready:
                    self.cameraService.capturePhoto()
                    self.gameState = .takingPicture
                case .resultReturned(_, _):
                    self.gameState = .ready
                default:
                    break
                }
            }
        }.store(in: &bag)
        
        cameraService.$photo.sink { _ in
            
        } receiveValue: { photo in
            guard let image = photo?.image else {
//                self.gameState = .resultReturned() TODO error
                return
            }
            self.mlService.processImage(image: image)
            self.gameState = .processingPicture(image)
        }.store(in: &bag)
        
        mlService.$output.sink { result in
            switch result {
            case .error:
                print("there was an error")
            case .nothing:
                break
            case .sucess(let results):
                print("\(results)")
                
                let scanedResult = ScanResult(identifications: results.map{ resultString in
                    let label = String(resultString.dropFirst(9))
                    
                    let numbers = resultString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                    
                    let confidence = Double(numbers) ?? 0.0
                    return Indentification(label: label, certainty: confidence)
                })
                self.gameState = .resultReturned(self.cameraService.photo!.image!, scanedResult)
                if let mainLabel = scanedResult.identifications.first?.label {
                    SpeechService().speakText(mainLabel)
                }
            }
        }.store(in: &bag)

        gameState = .ready
    }
    
    private let intents = PassthroughSubject<SimpleCameraViewIntent, Never>()
        
    public func process(intent: SimpleCameraViewIntent) {
        intents.send(intent)
    }
}

enum SimpleCameraState {
    case loading
    case ready
    case takingPicture
    case processingPicture(UIImage)
    case resultReturned(UIImage, ScanResult)
}
