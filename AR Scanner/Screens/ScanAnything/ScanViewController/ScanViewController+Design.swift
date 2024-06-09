import ARKit
import SnapKit

extension ScanViewController {
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        sceneView = ARSCNView()
        view.addSubview(sceneView)
        sceneView.delegate = self

        stopButton = UIButton()
        view.addSubview(stopButton)

        previewSceneView = SCNView()
        view.addSubview(previewSceneView)
    }

    public func styleViews() {
        navigationController?.setNavigationBarHidden(false, animated: false)

        stopButton.setTitle(LocalizableStrings.previewScan.localized, for: .normal)
        stopButton.applyMainButtonStyle()
        stopButton.isHidden = true

        previewSceneView.backgroundColor = .black
        previewSceneView.isHidden = true
    }

    public func defineLayoutForViews() {
        sceneView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        stopButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(defaultPadding * 3)
            $0.leading.trailing.equalToSuperview().inset(defaultPadding * 2)
            $0.height.equalTo(buttonHeight)
        }

        previewSceneView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
