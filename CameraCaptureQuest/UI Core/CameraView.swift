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
            cameraService.checkForPermissions()
            cameraService.configure()
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
            CameraPreview(session: cameraService.session)
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
    
    var resultText: some View {
        Text(responseText)
            .foregroundColor(.pink)
            .offset(x: 0, y: 40)
            .font(.bold(.system(size: 50))())
            .shadow(color: .white, radius: 4)
    }
    
    var responseText: String {
        return ""
    }
    
    var buttonText: String {
        return "Cature".uppercased()
    }
    
    func takePicture() {
        print("taking picture")
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
