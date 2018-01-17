import Foundation

public struct User {
    public let firstName: String
    public let lastName: String
    public var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    public init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}
