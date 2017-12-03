import XCTest
import Entity
import CoreLocation
@testable import DataTransformer

class UserJsonDataTransformerTests: XCTestCase {
    var transformer: UserJsonDataTransformer!
    
    func testTransformFromJsonDataToUser() {
        let user = transformer.transform(Data.fake())
        XCTAssertEqual(user, User.fake())
    }
    
    func testTransformFromUserToJsonData() {
        let input = User.fake()
        let data = transformer.transform(input)
        let output = transformer.transform(data)
        XCTAssertEqual(output, input)
    }
    
    override func setUp() {
        super.setUp()
        transformer = UserJsonDataTransformer()
    }
    
    override func tearDown() {
        super.tearDown()
        transformer = nil
    }
}

private extension String {
    static let firstName: String = "fakeFirstName"
    static let lastName: String = "fakeLastName"
}

private extension User {
    static func fake() -> User {
        let user = User(firstName: .firstName, lastName: .lastName)
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

private func XCTAssertEqual(_ a: User, _ b: User, file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(a.firstName, b.firstName)
    XCTAssertEqual(a.lastName, b.lastName)
}
