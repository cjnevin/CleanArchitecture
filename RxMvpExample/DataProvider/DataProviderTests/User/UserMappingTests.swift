import Foundation
import XCTest
import Model
@testable import DataProvider

class UserMappingTests: XCTestCase {
    func testTransformFromDtoToModel() {
        let userDto = UserDto.fake()
        XCTAssertEqual(userDto.asModel(), userDto)
    }
    
    func testTransformFromModelToDto() {
        let user = User.fake()
        XCTAssertEqual(user, user.asDto())
    }
}

extension UserDto {
    static func fake() -> UserDto {
        return UserDto(firstName: "firstName", lastName: "lastName")
    }
}

extension User {
    static func fake() -> User {
        return User(firstName: "firstName", lastName: "lastName")
    }
}

private func XCTAssertEqual(_ a: User, _ b: UserDto, file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(a.firstName, b.firstName)
    XCTAssertEqual(a.lastName, b.lastName)
}

