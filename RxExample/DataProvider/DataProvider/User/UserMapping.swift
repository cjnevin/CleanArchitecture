import Foundation
import Model

public struct UserDto {
    public let firstName: String
    public let lastName: String
    
    public init(firstName: String,
                lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

extension UserDto {
    func asModel() -> User {
        return User(firstName: firstName,
                    lastName: lastName)
    }
}

extension User {
    func asDto() -> UserDto {
        return UserDto(firstName: firstName,
                       lastName: lastName)
    }
}

