import UIKit
import DataProvider
import Presentation
import UseCase
import StorageService
import ApiService

extension DataProvider.UserProvider {
    static var `default`: DataProvider.UserProvider {
        return UserProvider(storage: UserStorageService(),
                            api: UserApiService())
    }
}

struct UserViewFactory {
    typealias Navigator = UserNavigator
    typealias View = UserViewController
    typealias Presenter = UserPresenter<View>
    typealias UseCase = GetUserUseCase
    
    private let provider: DataProvider.UserProvider
    init(provider: DataProvider.UserProvider = .default) {
        self.provider = provider
    }
    
    func makeUserView() -> UINavigationController {
        let viewController = View()
        let navigator = Navigator()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigator.navigationController = navigationController
        viewController.navigator = navigator
        viewController.presenter = Presenter(useCase: UseCase(provider: provider))
        return navigationController
    }
}
