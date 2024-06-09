import UIKit
import ARKit
import SnapKit

extension VirtualObjectViewController {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        sceneView = ARSCNView()
        sceneView.configure(session)
        sceneView.delegate = self
        view.addSubview(sceneView)

        addButton = UIButton()
        sceneView.addSubview(addButton)
    }

    public func styleViews() {
        addButton.setTitle(LocalizableStrings.addVirtualObject.localized, for: .normal)
        addButton.applyMainButtonStyle()
        addButton.alpha = 0.5
    }

    public func defineLayoutForViews() {
        sceneView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        addButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(defaultPadding * 3)
            $0.leading.trailing.equalToSuperview().inset(defaultPadding * 2)
            $0.height.equalTo(buttonHeight)
        }
    }

}
