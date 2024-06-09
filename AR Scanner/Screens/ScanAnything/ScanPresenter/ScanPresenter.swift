import SceneKit
import ARKit

class ScanPresenter {

    var isSessionRunning = false
    var scannedNode: SCNNode?
    var isPreviewing = false

    func startSession(_ session: ARSession) {
        guard !isSessionRunning else { return }

        let configuration = ARWorldTrackingConfiguration()
        configuration.sceneReconstruction = .mesh
        session.run(configuration)

        isSessionRunning = true
        scannedNode?.removeFromParentNode()
        scannedNode = nil
        isPreviewing = false
    }

    func stopSession(_ session: ARSession) {
        guard isSessionRunning else { return }

        session.pause()
        isSessionRunning = false
        createPreviewNode(session)
    }

private func createPreviewNode(_ session: ARSession) {
    let node = SCNNode()

    guard let frame = session.currentFrame else { return }

    for anchor in frame.anchors {
        if let meshAnchor = anchor as? ARMeshAnchor {
            let geometry = createGeometry(from: meshAnchor)
            let meshNode = SCNNode(geometry: geometry)
            meshNode.transform = SCNMatrix4(meshAnchor.transform)
            node.addChildNode(meshNode)
        }
    }

    scannedNode = node
}

    // MARK: - Geometry Creation
    func createGeometry(from meshAnchor: ARMeshAnchor) -> SCNGeometry {
        let vertices = meshAnchor.geometry.vertices
        let normals = meshAnchor.geometry.normals
        let faces = meshAnchor.geometry.faces

        let vertexSource = SCNGeometrySource(
            buffer: vertices.buffer,
            vertexFormat: vertices.format,
            semantic: .vertex,
            vertexCount: vertices.count,
            dataOffset: vertices.offset,
            dataStride: vertices.stride)

        let normalSource = SCNGeometrySource(
            buffer: normals.buffer,
            vertexFormat: normals.format,
            semantic: .normal,
            vertexCount: normals.count,
            dataOffset: normals.offset,
            dataStride: normals.stride)

        let faceElement = SCNGeometryElement(
            buffer: faces.buffer,
            primitiveType: .line,
            primitiveCount: faces.count,
            bytesPerIndex: faces.bytesPerIndex)

        return SCNGeometry(sources: [vertexSource, normalSource], elements: [faceElement])
    }


}
