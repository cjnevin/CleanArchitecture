import Foundation
import UseCase
import Model
import RxSwift

public protocol LocationService {
    func getCurrentLocation() -> Observable<LocationDto>
}

public struct UserLocationProvider: UseCase.UserLocationProvider {
    private let service: LocationService

    public init(service: LocationService) {
        self.service = service
    }

    public func getLocation() -> Observable<Location> {
        return service.getCurrentLocation()
            .map { $0.asModel() }
    }
}
