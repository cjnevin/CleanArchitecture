import Foundation
import DataTransformer
import StorageService
import ApiService
import DataProvider
import UseCase

struct GetUserUseCaseFactory {
    private let provider: DataProvider.UserProvider

    init() {
        let transformer = UserJsonDataTransformer()
        let storage = UserStorageService()
        let api = UserApiService(transformer: transformer)
        self.provider = UserProvider(storage: storage, api: api)
    }

    func makeGetUserUseCase() -> GetUserUseCase {
        return GetUserUseCase(provider: provider)
    }
}
