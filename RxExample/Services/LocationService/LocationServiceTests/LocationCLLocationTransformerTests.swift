import XCTest
import Model
import CoreLocation
@testable import DataTransformer

class LocationCLLocationTransformerTests: XCTestCase {
    var transformer: LocationCLLocationTransformer!
    
    func testTransformFromCLLocationToLocation() {
        let clLocation = CLLocation(latitude: 1, longitude: 2)
        let location = transformer.transform(clLocation)
        XCTAssertEqual(clLocation, location)
    }
    
    func testTransformFromLocationToCLLocation() {
        let location = Location(latitude: 1, longitude: 2)
        let clLocation = transformer.transform(location)
        XCTAssertEqual(clLocation, location)
    }
    
    override func setUp() {
        super.setUp()
        transformer = LocationCLLocationTransformer()
    }
    
    override func tearDown() {
        super.tearDown()
        transformer = nil
    }
}

private func XCTAssertEqual(_ clLocation: CLLocation, _ location: Location, file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(clLocation.coordinate.latitude, location.latitude, file: file, line: line)
    XCTAssertEqual(clLocation.coordinate.longitude, location.longitude, file: file, line: line)
}
