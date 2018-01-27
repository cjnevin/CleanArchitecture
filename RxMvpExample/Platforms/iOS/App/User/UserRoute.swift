import Presentation
import RxSwift
import UseCase
import DataProvider
import StorageService
import ApiService
import UIKit

extension DataProvider.UserProvider {
    static var `default`: DataProvider.UserProvider {
        return UserProvider(storage: UserStorageService(),
                api: UserApiService())
    }
}

class UserRoute: Route, NavigatorHaving {
    let source: Route? = nil
    let path: String = "user"
    let uniqueId: String = UUID().uuidString
    let navigator: Navigator
    weak var wireframe: Wireframe?

    init(navigator: Navigator, wireframe: Wireframe) {
        self.navigator = navigator
        self.wireframe = wireframe
    }

    private func makeViewController() -> UserViewController? {
        guard let wireframe = wireframe else {
            return nil
        }
        let viewController = UserViewController()
        let useCase = GetUserUseCase(provider: DataProvider.UserProvider.default)
        let presenter = UserPresenter<UserViewController>(route: self, wireframe: wireframe, useCase: useCase)
        viewController.presenter = presenter
        return viewController
    }

    func navigate(animated: Bool) -> Completable {
        guard let viewController = makeViewController() else {
            return .error(NavigationError.incorrectConfiguration)
        }
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigator.show(navigationController,
                with: RootNavigationMode(animated: animated))
    }
}
