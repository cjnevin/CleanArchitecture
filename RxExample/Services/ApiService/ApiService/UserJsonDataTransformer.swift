import Foundation
import Entity

private struct UserData: Codable {
    let firstName: String
    let lastName: String
}

private struct UserTransformer {
    func transform(_ object: User) -> UserData {
        return UserData(firstName: object.firstName,
                lastName: object.lastName)
    }

    func transform(_ object: UserData) -> User {
        return User(firstName: object.firstName,
                lastName: object.lastName)
    }
}

struct UserJsonDataTransformer {
    func transform(_ object: Data) -> User {
        let decoder = JSONDecoder()
        let userData = try! decoder.decode(UserData.self, from: object)
        let user = UserTransformer().transform(userData)
        return user
    }

    func transform(_ object: User) -> Data {
        let encoder = JSONEncoder()
        let userData = UserTransformer().transform(object)
        let data = try! encoder.encode(userData)
        return data
    }
}
