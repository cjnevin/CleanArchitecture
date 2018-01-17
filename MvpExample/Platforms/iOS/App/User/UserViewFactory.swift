import UIKit
import Presenter
import DataTransformer

struct UserViewFactory {
	private let useCaseFactory = GetUserUseCaseFactory()

	func makeUserView() -> UINavigationController {
		let viewController = UserViewController()
		let navigator = UserNavigator()
		let presenter = UserPresenter(useCase: useCaseFactory.makeGetUserUseCase(),
									  navigator: navigator)
		let navigationController = UINavigationController(rootViewController: viewController)
		navigator.navigationController = navigationController
		viewController.presenter = presenter
		return navigationController
	}
}
