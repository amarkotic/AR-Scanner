import ARKit
import SnapKit

extension MenuViewController {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        titleLabel = UILabel()
        view.addSubview(titleLabel)

        stackView = UIStackView()
        view.addSubview(stackView)

        scanAnythingButton = UIButton(type: .system)
        stackView.addArrangedSubview(scanAnythingButton)

        notificationLabel = UILabel()
        stackView.addArrangedSubview(notificationLabel)

        interiorScanButton = UIButton(type: .system)
        stackView.addArrangedSubview(interiorScanButton)

        virtualObjectButton = UIButton(type: .system)
        stackView.addArrangedSubview(virtualObjectButton)
    }

    public func styleViews() {
        view.backgroundColor = .white

       titleLabel.text = "AR Scanner"
       titleLabel.textColor = .appBlue
        titleLabel.font = UIFont.futura(32)
       titleLabel.textAlignment = .center
       titleLabel.numberOfLines = 1

        stackView.axis = .vertical
        stackView.spacing = 60

        notificationLabel.text = LocalizableStrings.lidarSupportError.localized
        notificationLabel.textColor = .appBlue
        notificationLabel.font = UIFont.futura(18)
        notificationLabel.textAlignment = .center
        notificationLabel.numberOfLines = 0
        notificationLabel.isHidden = supportsLidar

        scanAnythingButton.setTitle(LocalizableStrings.scanAnything.localized, for: .normal)
        scanAnythingButton.applyMainButtonStyle()
        scanAnythingButton.isHidden = !supportsLidar

        interiorScanButton.setTitle(LocalizableStrings.interiorScan.localized, for: .normal)
        interiorScanButton.applyMainButtonStyle()
        interiorScanButton.isHidden = !supportsLidar

        virtualObjectButton.setTitle(LocalizableStrings.addVirtualObject.localized, for: .normal)
        virtualObjectButton.layer.opacity = 0.5
        virtualObjectButton.applyMainButtonStyle()

    }

    public func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets.top).inset(defaultPadding * 5)
            $0.leading.trailing.equalToSuperview().inset(defaultPadding * 2)
        }

        stackView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(defaultPadding * 2)
            $0.leading.trailing.equalToSuperview().inset(defaultPadding * 2)
            $0.center.equalToSuperview()
        }

        scanAnythingButton.snp.makeConstraints {
            $0.height.equalTo(buttonHeight)
        }

        interiorScanButton.snp.makeConstraints {
            $0.height.equalTo(buttonHeight)
        }

        virtualObjectButton.snp.makeConstraints {
            $0.height.equalTo(buttonHeight)
        }
    }

}
