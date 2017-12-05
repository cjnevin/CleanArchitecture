import Foundation
import Model
import RxSwift

public protocol UserProvider {
    func getUser() -> Single<User>
}

public struct GetUserUseCase {
    private let provider: UserProvider

    public init(provider: UserProvider) {
        self.provider = provider
    }

    public func getUser() -> Single<User> {
        return provider.getUser()
    }
}
