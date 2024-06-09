import UIKit
import ARKit
import SceneKit

public class ScanViewController: UIViewController {

    let defaultPadding: CGFloat = 16
    let cornerRadius: CGFloat = 4
    let buttonHeight: CGFloat = 60

    var sceneView: ARSCNView!
    var stopButton: UIButton!
    var previewSceneView: SCNView!

    private var presenter: ScanPresenter!

    init(presenter: ScanPresenter) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        setupActions()
        startSession()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = false
    }

    private func setupActions() {
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
    }

    @objc private func stopButtonTapped() {
        stopSession()
        showPreview()
    }

    private func startSession() {
        presenter.startSession(sceneView.session)

        stopButton.isHidden = false
        previewSceneView.isHidden = true
    }

    private func stopSession() {
        presenter.stopSession(sceneView.session)

        stopButton.isHidden = true
    }

    private func showPreview() {
        guard let scannedNode = presenter.scannedNode else { return }

        sceneView.isHidden = true

        let previewScene = SCNScene()
        previewScene.rootNode.addChildNode(scannedNode)

        previewSceneView.scene = previewScene
        previewSceneView.isHidden = false
        presenter.isPreviewing = true

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        previewSceneView.addGestureRecognizer(panGesture)
    }

    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let view = gesture.view as? SCNView, let nodeToRotate = presenter.scannedNode else { return }

        let translation = gesture.translation(in: view)
        let x = Float(translation.x) * (Float.pi / 180)
        let y = Float(-translation.y) * (Float.pi / 180)

        nodeToRotate.eulerAngles.x += y
        nodeToRotate.eulerAngles.y += x

        gesture.setTranslation(.zero, in: view)
    }

}

// MARK: - ARSCNViewDelegate
extension ScanViewController: ARSCNViewDelegate {

    public func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()

        if let meshAnchor = anchor as? ARMeshAnchor {
            let geometry = presenter.createGeometry(from: meshAnchor)
            node.geometry = geometry
        }

        return node
    }

public func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
    guard let frame = sceneView.session.currentFrame else { return }

    for anchor in frame.anchors {
        if let meshAnchor = anchor as? ARMeshAnchor {
            let geometry = presenter.createGeometry(from: meshAnchor)
            let node = sceneView.node(for: anchor)
            node?.geometry = geometry
        }
    }
}

}
