import SwiftUI

@main
struct CameraCaptureQuestApp: App {
    var body: some Scene {
        WindowGroup {
            let cameraModel = SimpleCameraModel()
            ContentView().environmentObject(cameraModel)
        }
    }
}
