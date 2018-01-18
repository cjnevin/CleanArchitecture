import Foundation
import XCTest
import Model
@testable import DataProvider

class LocationMappingTests: XCTestCase {
    func testTransformFromDtoToModel() {
        let locationDto = LocationDto.fake()
        XCTAssertEqual(locationDto.asModel(), locationDto)
    }
    
    func testTransformFromModelToDto() {
        let location = Location.fake()
        XCTAssertEqual(location, location.asDto())
    }
}

extension LocationDto {
    static func fake() -> LocationDto {
        return LocationDto(latitude: 1, longitude: 2)
    }
}

extension Location {
    static func fake() -> Location {
        return Location(latitude: 1, longitude: 2)
    }
}

private func XCTAssertEqual(_ a: Location, _ b: LocationDto, file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(a.latitude, b.latitude)
    XCTAssertEqual(a.longitude, b.longitude)
}


