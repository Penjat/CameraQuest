import SwiftUI

struct CameraView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Starts with").font(.title3)
                Text("B").font(.title)
            }
                camera.frame(height: UIScreen.main.bounds.width)
            
            takePictureButton
            Spacer()
        }
    }
    
    var takePictureButton: some View {
        ZStack {
            Rectangle().fill(Color.purple).padding(40)
            Text("Capture").font(.title).foregroundColor(.white)
        }
    }
    
    var camera: some View {
        ZStack {
            
            Circle()
                .fill(Color.yellow).shadow(radius: 40)
            Circle()
                .stroke(Color.blue, lineWidth: 8)
            VStack {
                Spacer()
                resultText.padding()
            }
        }
        
    }
    
    var resultText: some View {
        Text("Toy Poddle").font(.bold(.largeTitle)()).shadow(radius: 4)
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
