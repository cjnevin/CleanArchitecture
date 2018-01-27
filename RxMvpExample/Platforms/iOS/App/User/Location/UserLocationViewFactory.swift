import UIKit
import Presentation
import LocationService
import DataProvider
import UseCase

extension DataProvider.UserLocationProvider {
    static var `default`: DataProvider.UserLocationProvider {
        return DataProvider.UserLocationProvider(service: CurrentLocationService())
    }
}

struct UserLocationViewFactory {
    private typealias View = UserLocationViewController
    private typealias Presenter = UserLocationPresenter<View>
    private let provider: DataProvider.UserLocationProvider

    init(provider: DataProvider.UserLocationProvider = .default) {
        self.provider = provider
    }
    
    func makeUserLocationView() -> UserLocationViewController {
        let viewController = View()
        let presenter = Presenter(useCase: GetUserLocationUseCase(provider: provider))
        viewController.presenter = presenter
        return viewController
    }
}
