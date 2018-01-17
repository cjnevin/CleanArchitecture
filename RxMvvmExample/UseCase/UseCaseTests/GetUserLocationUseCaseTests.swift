import Foundation
import Model
import RxTest
import RxBlocking
import RxSwift
import Mock
import XCTest
@testable import UseCase

class GetUserLocationUseCaseTests: XCTestCase {
    private var provider: UserLocationProviderMock!
    private var useCase: GetUserLocationUseCase!
    
    func testGetLocationCallsProvider() {
        XCTAssertNoThrow(try useCase.getLocation().toBlocking().first())
        XCTAssertNotNil(try! useCase.getLocation().toBlocking().first())
        provider.getLocationMock.expect(count: .toBe(2))
    }
    
    override func setUp() {
        super.setUp()
        provider = UserLocationProviderMock()
        useCase = GetUserLocationUseCase(provider: provider)
    }
    
    override func tearDown() {
        super.tearDown()
        provider = nil
    }
}

fileprivate class UserLocationProviderMock: UserLocationProvider {
    let getLocationMock = Mock(Observable.just(Location(latitude: 1, longitude: 2)))
    func getLocation() -> Observable<Location> {
        return getLocationMock.execute()
    }
}
