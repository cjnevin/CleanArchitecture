import XCTest
import DataProvider
import CoreLocation
@testable import ApiService

class UserMappingTests: XCTestCase {
    func testTransformFromJsonDataToUser() {
        XCTAssertEqual(Data.fake().asDto(), UserDto.fake())
    }
    
    func testTransformFromUserToJsonData() {
        let input = UserDto.fake()
        let output = input.asData().asDto()
        XCTAssertEqual(output, input)
    }
}

private extension String {
    static let firstName: String = "fakeFirstName"
    static let lastName: String = "fakeLastName"
}

private extension UserDto {
    static func fake() -> UserDto {
        let user = UserDto(firstName: .firstName, lastName: .lastName)
        return user
    }
}

private extension Data {
    static func fake() -> Data {
        let response = ["firstName": String.firstName,
                        "lastName": String.lastName]
        let data = try! JSONSerialization.data(withJSONObject: response, options: .init(rawValue: 0))
        return data
    }
}

private func XCTAssertEqual(_ a: UserDto, _ b: UserDto, file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(a.firstName, b.firstName)
    XCTAssertEqual(a.lastName, b.lastName)
}
