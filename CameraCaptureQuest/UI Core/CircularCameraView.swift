import SwiftUI

struct CircularCameraView: View {
    let cameraState: CameraState
    var body: some View {
        GeometryReader { geometry in
            switch cameraState {
            case .ready(let session):
                AnyView(CameraPreview(session: session).scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                            .clipped()
                            .mask(Circle()))
            case .loading:
                AnyView(Circle())
            case .success(let image):
                AnyView(Image(uiImage: image).resizable().aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                            .clipped().mask(Circle()))
            }
        }
    }
}

struct CircularCameraView_Previews: PreviewProvider {
    static var previews: some View {
        CircularCameraView(cameraState: .loading)
    }
}
