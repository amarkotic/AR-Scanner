import UIKit

class Coordinator: CoordinatorProtocol {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let menuPresenter = MenuPresenter(coordinator: self)
        let menuViewController = MenuViewController(presenter: menuPresenter)
        navigationController.pushViewController(menuViewController, animated: false)
    }

    func navigateToScanAnything() {
        let scanPresenter = ScanPresenter()
        let scanViewController = ScanViewController(presenter: scanPresenter)
        navigationController.pushViewController(scanViewController, animated: true)
    }

    func navigateToInteriorScan() {
        let interiorPresenter = InteriorPresenter(coordinator: self)
        let interiorScanVC = InteriorViewController(presenter: interiorPresenter)
        navigationController.pushViewController(interiorScanVC, animated: true)
    }

    func navigateToVirtualObject() {
        let virtualObjectPresenter = VirtualObjectPresenter()
        let virtualObjectViewController = VirtualObjectViewController(presenter: virtualObjectPresenter)
        navigationController.pushViewController(virtualObjectViewController, animated: true)
    }

    func showShareSheet(url: URL) {
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        navigationController.topViewController?.present(activityViewController, animated: true, completion: nil)
    }

}
