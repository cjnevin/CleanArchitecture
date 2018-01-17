import Foundation
import Model
import RxSwift

public protocol UserLocationProvider {
    func getLocation() -> Observable<Location>
}

public struct GetUserLocationUseCase {
    private let provider: UserLocationProvider
    
    public init(provider: UserLocationProvider) {
        self.provider = provider
    }

    public func getLocation() -> Observable<Location> {
        return provider.getLocation()
    }
}
