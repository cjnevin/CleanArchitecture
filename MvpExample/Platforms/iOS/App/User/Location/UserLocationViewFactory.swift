import UIKit
import Presenter
import DataTransformer

struct UserLocationViewFactory {
	private let useCaseFactory = GetLocationUseCaseFactory()
	let navigationController: UINavigationController?
	
	func makeUserLocationView() -> UserLocationViewController {
		let viewController = UserLocationViewController()
		let navigator = UserLocationNavigator()
		let presenter = UserLocationPresenter(useCase: useCaseFactory.makeGetLocationUseCase(),
											  navigator: navigator)
		navigator.navigationController = navigationController
		viewController.presenter = presenter
		return viewController
	}
}
