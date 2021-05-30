import AVFoundation
import UIKit

enum CameraState {
    case ready(AVCaptureSession)
    case loading
    case success(UIImage)
}
