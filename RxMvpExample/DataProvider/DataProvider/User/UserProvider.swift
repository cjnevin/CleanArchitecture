import Foundation
import UseCase
import Model
import RxSwift

public protocol UserStorageService {
    func getUser() -> Single<UserDto>
    func setUser(_ user: UserDto) -> Completable
}

public protocol UserApiService {
    func fetchUser() -> Single<UserDto>
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
                .map { $0.asModel() }
                .catchError(GetUserError.map)
    }
}

public enum GetUserError: Swift.Error {
    case notFound
    case unknown
    
    static func map(error: Error) -> Single<User> {
        return .error(error.asGetUserError().asGetUserUseCaseError())
    }
}

fileprivate extension Error {
    func asGetUserError() -> GetUserError {
        guard let error = self as? GetUserError else {
            return GetUserError.unknown
        }
        return error
    }
}

fileprivate extension GetUserError {
    func asGetUserUseCaseError() -> GetUserUseCase.Error {
        switch self {
        case .notFound: return .notFound
        case .unknown: return .unknown
        }
    }
} 
