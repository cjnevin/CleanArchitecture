import UIKit
import Presenter

class UserNavigator: Presenter.UserNavigator {
    weak var navigationController: UINavigationController?
    
    func navigateToUserLocation() {
		let viewFactory = UserLocationViewFactory(navigationController: navigationController)
        let viewController = viewFactory.makeUserLocationView()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
