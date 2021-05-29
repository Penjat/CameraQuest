import SwiftUI

struct CameraView: View {
    @State var circleColor: Color = Color.purple
    var body: some View {
        VStack {
            HStack {
                Text("Starts with").font(.callout)
                Text("B").font(.bold(.title)())
            }
                camera.frame(height: UIScreen.main.bounds.width)
            Spacer()
            takePictureButton.onTapGesture {
                takePicture()
            }
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
            Circle()
                .fill(circleColor).shadow(radius: 40)
            Circle()
                .stroke(Color.blue, lineWidth: 8)
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
        circleColor = .purple
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
