import UIKit
import ARKit
import SceneKit

public class VirtualObjectViewController: UIViewController {

    let defaultPadding: CGFloat = 16
    let cornerRadius: CGFloat = 4
    let buttonHeight: CGFloat = 60

    let session = ARSession()

    var sceneView: ARSCNView!
    var addButton: UIButton!
    var centerOfTheScreen: CGPoint?

    private var currentObject: SCNNode?
    private var presenter: VirtualObjectPresenter!

    init(presenter: VirtualObjectPresenter) {
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
        presenter.startSession(session)
        addGestureRecognizers()
    }

    private func addGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }

    private func setupActions() {
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addButtonTapped() {
        currentObject = presenter.addVirtualObject(screenCenter: centerOfTheScreen, scene: sceneView)
        addButton.isHidden = true
    }

}

// Lifecycle funcs
extension VirtualObjectViewController {

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        centerOfTheScreen = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = false
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        session.pause()
    }
    

}

extension VirtualObjectViewController {

    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(location, options: nil)

        if let tappedNode = hitTestResults.first?.node {
            tappedNode.removeFromParentNode()
            addButton.isHidden = false
        }
    }

}
