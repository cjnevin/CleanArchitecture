import Foundation
import StorageService
import ApiService
import DataProvider
import UseCase

struct GetUserUseCaseFactory {
    private let provider: DataProvider.UserProvider

    init() {
        let storage = UserStorageService()
        let api = UserApiService()
        self.provider = UserProvider(storage: storage, api: api)
    }

    func makeGetUserUseCase() -> GetUserUseCase {
        return GetUserUseCase(provider: provider)
    }
}
