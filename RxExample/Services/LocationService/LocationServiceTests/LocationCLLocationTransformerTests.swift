import XCTest
import CoreLocation
import DataProvider
@testable import LocationService

class LocationMappingTests: XCTestCase {
    func testTransformFromCLLocationToLocation() {
        let clLocation = CLLocation(latitude: 1, longitude: 2)
        let location = clLocation.asDto()
        XCTAssertEqual(clLocation, location)
    }
    
    func testTransformFromLocationToCLLocation() {
        let location = LocationDto(latitude: 1, longitude: 2)
        let clLocation = location.asCLLocation()
        XCTAssertEqual(clLocation, location)
    }
}

private func XCTAssertEqual(_ clLocation: CLLocation, _ location: LocationDto, file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(clLocation.coordinate.latitude, location.latitude, file: file, line: line)
    XCTAssertEqual(clLocation.coordinate.longitude, location.longitude, file: file, line: line)
}
