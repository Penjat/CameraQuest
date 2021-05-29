import SwiftUI

struct CameraView: View {
    @EnvironmentObject var viewModel: SimpleCameraModel
    @State var circleColor: Color = Color.blue
    
    var body: some View {
        VStack {
            HStack {
                Text("Starts with").font(.callout)
                Text("B").font(.bold(.title)())
            }
            camera//.frame(height: UIScreen.main.bounds.width)
            Spacer()
            takePictureButton.onTapGesture {
                takePicture()
            }
        }.onAppear {
            
        }
    }
    
    var takePictureButton: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .cornerRadius(12)
                .padding(40)
                .shadow(radius: 10)
            Text(buttonText)
                .font(.bold(.title)())
                .foregroundColor(.white)
        }.frame(maxHeight: 250)
    }
    
    var camera: some View {
        ZStack {
            cameraImage
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width)
                .mask(Circle().padding())
            Circle()
                .stroke(circleColor, lineWidth: 12)
            VStack {
                resultText.padding()
            }
        }
    }
    
    var cameraImage: some View {
        switch viewModel.modelState {
        case .processingPicture(let image), .resultReturned(let image, _):
            return AnyView(Image(uiImage: image).resizable().aspectRatio(contentMode: .fill))
        default:
            return AnyView(CameraPreview(session: viewModel.session))
        }
    }
    
    var resultText: some View {
        Text(responseText)
            .foregroundColor(.pink)
            .offset(x: 0, y: 40)
            .font(.bold(.system(size: 50))())
            .shadow(color: .white, radius: 4)
    }
    
    var responseText: String {
        switch viewModel.modelState {
        case .resultReturned(_, let resultText):
            return resultText
        default:
            return ""
        }
    }
    
    var buttonText: String {
        switch viewModel.modelState {
        case .loading:
            return "loading..."
        case .processingPicture:
            return "processing"
        case .ready:
            return "capture"
        case .takingPicture:
            return "taking picture"
        case .resultReturned:
            return "again?"
        }
    }
    
    func takePicture() {
        viewModel.process(intent: .pressedButton)
        withAnimation {
            circleColor = .white
        }
        circleColor = .blue
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
