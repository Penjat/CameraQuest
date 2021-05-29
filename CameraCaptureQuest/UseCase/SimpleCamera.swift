import Combine
import AVKit

class SimpleCameraModel: ObservableObject {
    @Published var modelState: SimpleCameraState = .loading
    
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
            case .takePicture:
                self.cameraService.capturePhoto()
                self.modelState = .takingPicture
            }
        }.store(in: &bag)
        
        cameraService.$photo.sink { _ in
            
        } receiveValue: { photo in
            guard let image = photo?.image else {
//                self.modelState = .resultReturned() TODO error
                return
            }
            self.modelState = .processingPicture(image)
        }.store(in: &bag)

        
        modelState = .ready
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
    case resultReturned(UIImage, String)
}
