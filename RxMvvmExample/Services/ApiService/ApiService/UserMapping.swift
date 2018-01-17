import Foundation
import DataProvider

private struct UserData: Codable {
    let firstName: String
    let lastName: String
}

private extension UserData {
    func asDto() -> UserDto {
        return UserDto(firstName: firstName,
                       lastName: lastName)
    }
}

private extension UserDto {
    func asUserData() -> UserData {
        return UserData(firstName: firstName,
                        lastName: lastName)
    }
}

extension Data {
    func asDto() -> UserDto {
        let decoder = JSONDecoder()
        let userData = try! decoder.decode(UserData.self, from: self)
        return userData.asDto()
    }
}

extension UserDto {
    func asData() -> Data {
        let encoder = JSONEncoder()
        let userData = asUserData()
        let data = try! encoder.encode(userData)
        return data
    }
}

