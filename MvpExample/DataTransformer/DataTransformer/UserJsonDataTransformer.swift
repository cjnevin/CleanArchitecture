import Foundation
import Entity

// Unfortunately you can't add Codable as an extension (yet!) of the Entity.User object
// so we need to create a codable copy here and a transformer.
//
// This is important so we don't leak implementation details to the Model objects.
private struct UserData: Codable {
    let firstName: String
    let lastName: String
}

private struct UserTransformer: TwoWayTransformer {
    typealias TypeA = UserData
    typealias TypeB = User
    
    func transform(_ object: User) -> UserData {
        return UserData(firstName: object.firstName,
                        lastName: object.lastName)
    }
    
    func transform(_ object: UserData) -> User {
        return User(firstName: object.firstName,
                    lastName: object.lastName)
    }
}

public struct UserJsonDataTransformer: TwoWayTransformer {
    public typealias TypeA = Data
    public typealias TypeB = User
    
    public init() { }
    
    public func transform(_ object: Data) -> User {
        let decoder = JSONDecoder()
        let userData = try! decoder.decode(UserData.self, from: object)
        let user = UserTransformer().transform(userData)
        return user
    }
    
    public func transform(_ object: User) -> Data {
        let encoder = JSONEncoder()
        let userData = UserTransformer().transform(object)
        let data = try! encoder.encode(userData)
        return data
    }
}
