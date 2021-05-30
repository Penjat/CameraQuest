import SwiftUI

struct CircularCameraView: View {
    let cameraState: CameraState
    var body: some View {
        switch cameraState {
        case .ready(let session):
            return AnyView(CameraPreview(session: session).mask(Circle()))
        case .loading:
            return AnyView(Circle())
        case .success(let image):
            return AnyView(Image(uiImage: image).resizable().aspectRatio(contentMode: .fill).mask(Circle()))
        }
    }
}

struct CircularCameraView_Previews: PreviewProvider {
    static var previews: some View {
        CircularCameraView(cameraState: .loading)
    }
}
