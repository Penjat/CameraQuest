import SwiftUI

struct TitleView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Capture Quest")
                    .font(.largeTitle)
                NavigationLink(destination: SimpleCameraView()) {
                    Text("Simple Camera")
                }
            }
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
