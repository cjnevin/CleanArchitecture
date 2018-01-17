import Foundation
import DataProvider
import RxSwift

public struct UserApiService: DataProvider.UserApiService {
    public init() { }
    
    private func fakeData() -> Data {
        // Fake Api call yielding a response ...
        let response = ["firstName": "fakeFirstName",
                        "lastName": "fakeLastName"]
        let data = try! JSONSerialization.data(withJSONObject: response, options: .init(rawValue: 0))
        return data
    }

    public func fetchUser() -> Single<UserDto> {
        let data = fakeData()
        let user = data.asDto()
        return .just(user)
    }
}
