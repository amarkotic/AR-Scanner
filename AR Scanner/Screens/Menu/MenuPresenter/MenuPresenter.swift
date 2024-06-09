class MenuPresenter {

    var coordinator: CoordinatorProtocol

    init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
    }

func showScanAnything() {
    coordinator.navigateToScanAnything()
}
    
    func showInteriorScan() {
        coordinator.navigateToInteriorScan()
    }
    
    func showVirtualObject() {
        coordinator.navigateToVirtualObject()
    }

}
