import ARKit

class VirtualObjectPresenter {

    func startSession(_ session: ARSession) {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

    func addVirtualObject(screenCenter: CGPoint?, scene: ARSCNView) -> SCNNode? {
        guard
            let center = screenCenter,
            let query = scene.raycastQuery(from: center, allowing: .estimatedPlane, alignment: .horizontal),
            let transform = scene.session.raycast(query).first?.worldTransform
        else { return nil }

        guard
            let virtualObject = fetchObject()
        else {
            print("Error while fetching virtual object")
            return nil
        }

        let position = SCNVector3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
        virtualObject.scale = SCNVector3(0.01, 0.01, 0.01)
        virtualObject.position = position

        virtualObject.enumerateChildNodes { (node, item) in
            node.castsShadow = true
            node.geometry?.firstMaterial?.lightingModel = .physicallyBased
        }

        scene.autoenablesDefaultLighting = true
        scene.scene.rootNode.castsShadow = true
        scene.automaticallyUpdatesLighting = true
        scene.scene.rootNode.addChildNode(virtualObject)

        return virtualObject
    }

}

private extension VirtualObjectPresenter {

    func fetchObject() -> SCNNode? {
        guard let url = Bundle.main.url(forResource: "chair", withExtension: "usdz") else {
            print("Failed to fetch resource")
            return nil
        }

        guard let scene = try? SCNScene(url: url) else {
            print("Error while creating virtual object")
            return nil
        }

        let modelNode = scene.rootNode.childNodes.first
        return modelNode
    }

}
