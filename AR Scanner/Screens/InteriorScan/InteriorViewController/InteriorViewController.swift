import UIKit
import RoomPlan

public class InteriorViewController: UIViewController {

    let buttonSize = CGSize(width: 100, height: 60)
    let cornerRadius: CGFloat = 4
    let defaultPadding: CGFloat = 16

    var roomCaptureView: RoomCaptureView!
    var saveButton: UIButton!
    var exportButton: UIButton!

    private var presenter: InteriorPresenter!

    init(presenter: InteriorPresenter) {
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

    private func setupActions() {
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        exportButton.addTarget(self, action: #selector(exportTapped), for: .touchUpInside)
    }

    private func startSession() {
        let config = RoomCaptureSession.Configuration()
        roomCaptureView.captureSession.delegate = self
        roomCaptureView.captureSession.run(configuration: config)
    }

    @objc private func saveTapped() {
        roomCaptureView.captureSession.stop()
        presenter.saveCapturedRoom()
        saveButton.isHidden = true
        exportButton.isHidden = false
    }

    @objc private func exportTapped() {
        presenter.exportCapturedRoom()
    }

}

// RoomCaptureSessionDelegate methods
extension InteriorViewController: RoomCaptureSessionDelegate {

    public func captureSession(_ session: RoomCaptureSession, didUpdate room: CapturedRoom) {
        presenter.capturedRoom = room
        DispatchQueue.main.async {
            self.saveButton.isHidden = false
        }
    }

    public func captureSession(_ session: RoomCaptureSession, didEndWith data: CapturedRoomData, error: Error?) {
        guard error == nil else {
            DispatchQueue.main.async {
                self.saveButton.isHidden = true
                self.exportButton.isHidden = true
            }
            return
        }

        DispatchQueue.main.async {
            self.saveButton.isHidden = true
        }
    }

}
