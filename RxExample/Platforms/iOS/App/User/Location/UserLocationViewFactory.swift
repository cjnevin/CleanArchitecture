import UIKit
import Presentation

struct UserLocationViewFactory {
    private let useCaseFactory = GetLocationUseCaseFactory()
    let navigationController: UINavigationController?

    func makeUserLocationView() -> UserLocationViewController {
        let viewController = UserLocationViewController()
        let viewModel = UserLocationViewModel(useCase: useCaseFactory.makeGetLocationUseCase())
        viewController.viewModel = viewModel
        return viewController
    }
}
