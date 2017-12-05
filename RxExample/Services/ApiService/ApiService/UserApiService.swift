import Foundation
import DataProvider
import Model
import RxSwift

public struct UserApiService: DataProvider.UserApiService {
    private let transformer: UserJsonDataTransformer

    public init() {
        transformer = UserJsonDataTransformer()
    }

    private func fakeData() -> Data {
        // Fake Api call yielding a response ...
        let response = ["firstName": "fakeFirstName",
                        "lastName": "fakeLastName"]
        let data = try! JSONSerialization.data(withJSONObject: response, options: .init(rawValue: 0))
        return data
    }

    public func fetchUser() -> Single<User> {
        let data = fakeData()
        let user = transformer.transform(data)
        return .just(user)
    }
}
