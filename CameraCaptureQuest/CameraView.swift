import SwiftUI

struct CameraView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Starts with").font(.callout)
                Text("B").font(.bold(.title)())
            }
                camera.frame(height: UIScreen.main.bounds.width)
            
            takePictureButton
            Spacer()
        }
    }
    
    var takePictureButton: some View {
        ZStack {
            Rectangle().fill(Color.blue).cornerRadius(12).padding(40)
            Text("Capture").font(.bold(.title)()).foregroundColor(.white)
        }
    }
    
    var camera: some View {
        ZStack {
            
            Circle()
                .fill(Color.yellow).shadow(radius: 40)
            Circle()
                .stroke(Color.blue, lineWidth: 8)
            VStack {
                resultText.padding()
            }
        }
        
    }
    
    var resultText: some View {
        Text("Toy Poddle")
            .foregroundColor(.pink)
            .offset(x: 0, y: 40)
            .font(.bold(.system(size: 50))())
            .shadow(color: .white, radius: 4)
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
