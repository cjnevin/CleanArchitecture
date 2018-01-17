import XCTest
import Model
import RxSwift
import RxBlocking
import RxTest
import Mock
@testable import DataProvider

private class UserLocationProviderTests: XCTestCase {
    var provider: UserLocationProvider!
    var service: LocationServiceMock!
    var scheduler: TestScheduler! = TestScheduler(initialClock: 0)
    var disposeBag: DisposeBag! = DisposeBag()
    
    func testProviderReturnsValues() {
        let values = scheduler.createHotObservable([
            next(10, LocationDto(latitude: 1, longitude: 2)),
            next(20, LocationDto(latitude: 3, longitude: 4)),
            next(30, LocationDto(latitude: 5, longitude: 6)),
            ])
        service.getMock.set(values.asObservable())
        
        let results = scheduler.createObserver(Location.self)
        scheduler.scheduleAt(0) {
            self.provider.getLocation().subscribe(results).disposed(by: self.disposeBag)
        }
        scheduler.start()
        
        XCTAssertEqual(results.events.count, 3)
        
        let actual = results.events.flatMap { $0.value.element }

        XCTAssertEqual(actual.count, 3)
        
        XCTAssertEqual(actual[0].latitude, 1)
        XCTAssertEqual(actual[1].latitude, 3)
        XCTAssertEqual(actual[2].latitude, 5)
        
        XCTAssertEqual(actual[0].longitude, 2)
        XCTAssertEqual(actual[1].longitude, 4)
        XCTAssertEqual(actual[2].longitude, 6)
    }
    
    override func setUp() {
        super.setUp()
        service = LocationServiceMock()
        provider = UserLocationProvider(service: service)
    }
    
    override func tearDown() {
        super.tearDown()
        provider = nil
        service = nil
        scheduler = nil
        disposeBag = nil
    }
}

private class LocationServiceMock: LocationService {
    let getMock = Mock(Observable<LocationDto>.just(LocationDto(latitude: 1, longitude: 2)))
    func getCurrentLocation() -> Observable<LocationDto> { return getMock.execute() }
}
