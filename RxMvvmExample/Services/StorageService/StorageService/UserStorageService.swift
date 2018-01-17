import Foundation
import DataProvider
import RxSwift

public struct UserStorageService: DataProvider.UserStorageService {
    // private let storage: StorageService<User>

    public init() {

    }

    public func getUser() -> Single<UserDto> {
        // TODO: Get from Storage
        return .error(GetUserError.notFound)
    }

    public func setUser(_ user: UserDto) -> Completable {
        // TODO: Store
        return .empty()
    }
}
