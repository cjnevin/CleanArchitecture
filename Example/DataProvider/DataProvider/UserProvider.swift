import Foundation
import UseCase
import Entity

public protocol UserStorageService {
    func getUser() -> User?
    func setUser(_ user: User)
}

public protocol UserApiService {
    func fetchUser() -> User
}

public struct UserProvider: UseCase.UserProvider {
    private let storage: UserStorageService
    private let api: UserApiService
    
    public init(storage: UserStorageService,
                api: UserApiService) {
        self.storage = storage
        self.api = api
    }
    
    public func getUser() -> User {
        guard let local = storage.getUser() else {
            let remote = api.fetchUser()
            storage.setUser(remote)
            return remote
        }
        return local
    }
}
