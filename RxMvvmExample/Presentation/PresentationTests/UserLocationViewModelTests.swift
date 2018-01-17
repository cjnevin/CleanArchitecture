import XCTest
import Mock
import RxTest
import RxSwift
import RxBlocking
import Model
import UseCase
@testable import Presentation

class UserLocationViewModelTests: XCTestCase {
    var viewModel: UserLocationViewModel!
    var useCase: GetUserLocationUseCase!
    var provider: UserLocationProviderMock!
    
    func testLocationIsReturnedFromUseCase() {
        let location = try! viewModel.rx.location().toBlocking().single()!
        XCTAssertEqual(location.latitude, 1)
        XCTAssertEqual(location.longitude, 2)
    }

    override func setUp() {
        super.setUp()
        provider = UserLocationProviderMock()
        useCase = GetUserLocationUseCase(provider: provider)
        viewModel = UserLocationViewModel(useCase: useCase)
    }

    override func tearDown() {
        super.tearDown()
        provider = nil
        useCase = nil
        viewModel = nil
    }
}

class UserLocationProviderMock: UseCase.UserLocationProvider {
    let getLocationMock = Mock(Observable<Location>.just(Location(latitude: 1, longitude: 2)))
    func getLocation() -> Observable<Location> {
        return getLocationMock.execute()
    }
}
