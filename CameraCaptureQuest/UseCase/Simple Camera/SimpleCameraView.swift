import SwiftUI

struct SimpleCameraView: View {
    @EnvironmentObject var viewModel: SimpleCameraModel
    @State var circleColor: Color = Color.blue
    @State var certainty: Double = 0.0
    @State var shutterClosed = false
    
    var body: some View {
        VStack {
            Spacer()
            camera
            Spacer()
            takePictureButton.onTapGesture {
                takePicture()
            }
        }.onReceive(viewModel.$gameState, perform: { gameState in
            switch gameState {
            case .takingPicture:
                withAnimation {
                    shutterClosed = true
                    circleColor = .purple
                }
                break
            default:
                withAnimation {
                    shutterClosed = false
                    circleColor = .blue
                }
                break
            }
        })
    }
    
    var takePictureButton: some View {
        ZStack {
            Rectangle()
                .fill(circleColor)
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
            CircularCameraView(cameraState: cameraState)
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width)
                //.mask(Circle().padding())
            Circle()//.border(Color.pink, width: 20)
                .stroke(circleColor, lineWidth: shutterClosed ? 600 : 20).mask(Circle())
            
            resultText.padding()
            
        }
    }
    
    var resultText: some View {
        VStack {
            Text(responseText)
                .id(responseText)
                .transition(.opacity.animation(.easeIn).combined(with: .move(edge: .bottom)))
                .animation(.easeIn)
                .foregroundColor(.pink)
                .offset(x: 0, y: 40)
                .font(.bold(.system(size: 50))())
                .shadow(color: .white, radius: 4)
            Text(certaintayText)
                .id(certaintayText)
                .transition(.opacity.animation(.easeIn.delay(1)).combined(with: .move(edge: .bottom)))
                .animation(Animation.easeIn.delay(1))
                .foregroundColor(.black)
                .offset(x: 0, y: 40)
                .font(.system(size: 20))
                .shadow(color: .white, radius: 4)
        }
    }
    
    var responseText: String {
        switch viewModel.gameState {
        case .resultReturned(_, let result):
            return result.identifications.first?.label ?? "???"
        default:
            return ""
        }
    }
    
    var certaintayText: String {
        switch viewModel.gameState {
        case .resultReturned(_, let result):
            return String(format: "%.0f", (result.identifications.first?.certainty ?? 0)) + "%"
        default:
            return ""
        }
    }
    
    var buttonText: String {
        switch viewModel.gameState {
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
    
    var cameraState: CameraState {
        switch viewModel.gameState {
        case .loading:
            return .loading
        case .processingPicture(let image), .resultReturned(let image, _):
            return .success(image)
        case .takingPicture, .ready:
            return .ready(viewModel.session)
        }
    }
    
    func takePicture() {
        viewModel.process(intent: .pressedButton)
    }
}

struct SimpleCameraView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleCameraView()
    }
}
