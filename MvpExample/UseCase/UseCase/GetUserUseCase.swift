import Foundation
import Entity

public protocol UserProvider {
    func getUser() -> User
}

public struct GetUserUseCase {
    private let provider: UserProvider
    
    public init(provider: UserProvider) {
        self.provider = provider
    }
    
    public func getUser() -> User {
        return provider.getUser()
    }
}
