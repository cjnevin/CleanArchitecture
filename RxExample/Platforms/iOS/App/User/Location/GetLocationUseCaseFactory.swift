import Foundation
import LocationService
import DataProvider
import UseCase

struct GetLocationUseCaseFactory {
    private let provider: DataProvider.UserLocationProvider

    init() {
        let service = CurrentLocationService()
        self.provider = UserLocationProvider(service: service)
    }

    func makeGetLocationUseCase() -> GetUserLocationUseCase {
        return GetUserLocationUseCase(provider: provider)
    }
}
