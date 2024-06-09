import RoomPlan

class InteriorPresenter {

    private let exportURL = FileManager.default.temporaryDirectory.appendingPathComponent("exportedRoom.usdz")

    var capturedRoom: CapturedRoom?

    private var coordinator: CoordinatorProtocol

    init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
    }


    func saveCapturedRoom() {
        guard
            let capturedRoom
        else { return }

        do {
            try capturedRoom.export(to: exportURL)
        } catch {
            print("Error : \(error)")
            return
        }
    }

    func exportCapturedRoom() {
        coordinator.showShareSheet(url: exportURL)
    }
}

