import ARKit
import SceneKit

extension VirtualObjectViewController: ARSCNViewDelegate {

    public func renderer(_ renderer: any SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            if
                let center = self.centerOfTheScreen,
                let query = self.sceneView.raycastQuery(from: center, allowing: .estimatedPlane, alignment: .horizontal)
            {
                if self.sceneView.session.raycast(query).isEmpty {
                    self.addButton.isEnabled = false
                    self.addButton.alpha = 0.5
                } else {
                    self.addButton.isEnabled = true
                    self.addButton.alpha = 1
                }
            }
        }
    }

}
