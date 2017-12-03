import Foundation
import DataTransformer
import LocationService
import DataProvider
import UseCase

struct GetLocationUseCaseFactory {
    private let provider: DataProvider.UserLocationProvider

    init() {
        let transformer = LocationCLLocationTransformer()
        let service = CurrentLocationService(transformer: transformer)
        self.provider = UserLocationProvider(service: service)
    }

    func makeGetLocationUseCase() -> GetUserLocationUseCase {
        return GetUserLocationUseCase(provider: provider)
    }
}
