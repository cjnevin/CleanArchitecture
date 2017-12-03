import Foundation
import UseCase
import Entity
import RxSwift

public protocol UserStorageService {
    func getUser() -> Single<User>
    func setUser(_ user: User) -> Completable
}

public protocol UserApiService {
    func fetchUser() -> Single<User>
}

public struct UserProvider: UseCase.UserProvider {
    private let storage: UserStorageService
    private let api: UserApiService

    public init(storage: UserStorageService,
                api: UserApiService) {
        self.storage = storage
        self.api = api
    }

    public func getUser() -> Single<User> {
        return storage.getUser()
                .catchError { _ in
                    return self.api.fetchUser()
                            .flatMap { user in
                                self.storage.setUser(user)
                                        .andThen(.just(user))
                            }
                }
    }
}
