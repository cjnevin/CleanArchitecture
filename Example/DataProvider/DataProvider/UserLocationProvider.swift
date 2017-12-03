import Foundation
import UseCase
import Entity

public protocol LocationService {
    func getCurrentLocation() -> Location
}

public struct UserLocationProvider: UseCase.UserLocationProvider {
    private let service: LocationService
    
    public init(service: LocationService) {
        self.service = service
    }
    
    public func getLocation() -> Location {
        return service.getCurrentLocation()
    }
}
