import Foundation

enum SimpleCameraViewIntent {
    case pressedButton
}

struct ScanResult {
    let identifications: [Indentification]
}

struct Indentification {
    let label: String
    let certainty: Double
}
