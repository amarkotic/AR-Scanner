import UIKit
import RoomPlan
import SnapKit

extension InteriorViewController {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        roomCaptureView = RoomCaptureView()
        view.addSubview(roomCaptureView)

        saveButton = UIButton(type: .system)
        view.addSubview(saveButton)

        exportButton = UIButton(type: .system)
        view.addSubview(exportButton)
    }

    public func styleViews() {
        view.backgroundColor = .white

        saveButton.setTitle(LocalizableStrings.save.localized, for: .normal)
        saveButton.applyMainButtonStyle()
        saveButton.isHidden = true

        exportButton.setTitle(LocalizableStrings.export.localized, for: .normal)
        exportButton.applyMainButtonStyle()
        exportButton.isHidden = true
    }

    public func defineLayoutForViews() {
        roomCaptureView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        saveButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(defaultPadding)
            $0.bottom.equalToSuperview().inset(defaultPadding * 3)
            $0.size.equalTo(buttonSize)
        }

        exportButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(defaultPadding)
            $0.bottom.equalToSuperview().inset(defaultPadding * 3)
            $0.size.equalTo(buttonSize)
        }
    }

}
