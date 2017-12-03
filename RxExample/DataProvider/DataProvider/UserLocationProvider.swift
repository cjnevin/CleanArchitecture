import Foundation
import UseCase
import Entity
import RxSwift

public protocol LocationService {
    func getCurrentLocation() -> Observable<Location>
}

public struct UserLocationProvider: UseCase.UserLocationProvider {
    private let service: LocationService

    public init(service: LocationService) {
        self.service = service
    }

    public func getLocation() -> Observable<Location> {
        return service.getCurrentLocation()
    }
}
