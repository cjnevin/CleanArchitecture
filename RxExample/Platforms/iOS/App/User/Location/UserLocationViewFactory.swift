import UIKit
import Presentation
import DataTransformer

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
