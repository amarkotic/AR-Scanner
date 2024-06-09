import ARKit
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let supportLiDAR = ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh)
        UserDefaults.standard.setValue(supportLiDAR, forKey: "supportLidar")

        return true
    }

}

