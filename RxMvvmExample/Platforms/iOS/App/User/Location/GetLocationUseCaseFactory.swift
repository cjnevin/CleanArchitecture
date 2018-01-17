import Foundation
import LocationService
import DataProvider
import UseCase

struct GetLocationUseCaseFactory {
    private let provider: DataProvider.UserLocationProvider

    init(service: DataProvider.LocationService = CurrentLocationService()) {
        self.provider = UserLocationProvider(service: service)
    }

    func makeGetLocationUseCase() -> GetUserLocationUseCase {
        return GetUserLocationUseCase(provider: provider)
    }
}
