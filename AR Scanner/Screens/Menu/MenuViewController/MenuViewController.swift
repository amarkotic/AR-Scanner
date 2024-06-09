import UIKit
import SnapKit

class MenuViewController: UIViewController {

    let defaultPadding: CGFloat = 16
    let buttonHeight: CGFloat = 80
    let supportsLidar: Bool = UserDefaults.standard.bool(forKey: "supportLidar")

    var titleLabel: UILabel!
    var stackView: UIStackView!
    var notificationLabel: UILabel!
    var scanAnythingButton: UIButton!
    var interiorScanButton: UIButton!
    var virtualObjectButton: UIButton!

    var presenter: MenuPresenter!

    init(presenter: MenuPresenter) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        buildViews()
        setupActions()
    }

    private func setupActions() {
        scanAnythingButton.addTarget(self, action: #selector(scanAnythingTapped), for: .touchUpInside)
        interiorScanButton.addTarget(self, action: #selector(interiorScanTapped), for: .touchUpInside)
        virtualObjectButton.addTarget(self, action: #selector(virtualObjectTapped), for: .touchUpInside)
    }

    @objc private func scanAnythingTapped() {
        presenter.showScanAnything()
    }

    @objc private func interiorScanTapped() {
        presenter.showInteriorScan()
    }

    @objc private func virtualObjectTapped() {
        presenter.showVirtualObject()
    }

}
