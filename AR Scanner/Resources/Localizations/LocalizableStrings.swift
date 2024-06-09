import Foundation

enum LocalizableStrings: String {

    case previewScan = "preview.scan"
    case save
    case export
    case lidarSupportError = "lidar.support.error"
    case scanAnything = "scan.anything"
    case interiorScan = "interior.scan"
    case addVirtualObject = "add.virtual.object"

    var localized: String {
        NSLocalizedString(rawValue, bundle: Bundle.main, comment: "")
    }

}
