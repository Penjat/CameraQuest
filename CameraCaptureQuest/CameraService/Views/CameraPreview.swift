import SwiftUI
import AVFoundation

public struct CameraPreview: UIViewRepresentable {
	public init(session: AVCaptureSession) {
		self.session = session
	}

    public class VideoPreviewView: UIView {
		public override class var layerClass: AnyClass {
             AVCaptureVideoPreviewLayer.self
        }
        
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
        
        public override func layoutSubviews() {
            super.layoutSubviews()
        }
    }
    
    let session: AVCaptureSession
    
	public func makeUIView(context: Context) -> VideoPreviewView {
        let view = VideoPreviewView()
        view.backgroundColor = .systemPink
        view.videoPreviewLayer.cornerRadius = 0
        view.videoPreviewLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        view.videoPreviewLayer.session = session
        view.videoPreviewLayer.connection?.videoOrientation = .portrait
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        return view
    }
    
	public func updateUIView(_ uiView: VideoPreviewView, context: Context) {
        
    }
}

struct CameraPreview_Previews: PreviewProvider {
    static var previews: some View {
        CameraPreview(session: AVCaptureSession())
            .frame(height: 300)
    }
}
