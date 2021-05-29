import Combine
import AVKit

class SimpleCameraModel: ObservableObject {
    @Published var modelState: SimpleCameraState = .loading
    let gameInteractor = GameInteractor()
//    var session: AVCaptureSession
}

enum SimpleCameraState {
    case loading
    case ready
    case takingPicture
    case processingPicture
    case resultReturned
}
