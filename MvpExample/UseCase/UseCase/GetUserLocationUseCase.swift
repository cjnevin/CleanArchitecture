import Foundation
import Entity

public protocol UserLocationProvider {
    func getLocation() -> Location
}

public struct GetUserLocationUseCase {
    private let provider: UserLocationProvider
    
    public init(provider: UserLocationProvider) {
        self.provider = provider
    }
    
    public func getLocation() -> Location {
        return provider.getLocation()
    }
}
