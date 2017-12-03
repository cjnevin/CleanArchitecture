import UIKit
import Presenter
import DataTransformer

struct UserViewFactory {
    private let useCaseFactory = GetUserUseCaseFactory()

    func makeUserView() -> UINavigationController {
        let viewController = UserViewController()
        let navigator = UserNavigator()
        let viewModel = UserViewModel(useCase: useCaseFactory.makeGetUserUseCase(),
                navigator: navigator)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigator.navigationController = navigationController
        viewController.viewModel = viewModel
        return navigationController
    }
}
