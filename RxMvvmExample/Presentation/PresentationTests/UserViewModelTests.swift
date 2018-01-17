import XCTest
import Mock
import RxTest
import RxSwift
import RxBlocking
import Model
import UseCase
@testable import Presentation

class UserViewModelTests: XCTestCase {
    var viewModel: UserViewModel!
    var useCase: GetUserUseCase!
    var provider: UserProviderMock!
    var navigator: UserNavigatorMock!
    
    func testFirstNameIsReturnedFromUseCase() {
        let subject = try! viewModel.rx.firstName.toBlocking().single()!
        XCTAssertEqual(subject, "firstName")
    }
    
    func testLastNameIsReturnedFromUseCase() {
        let subject = try! viewModel.rx.lastName.toBlocking().single()!
        XCTAssertEqual(subject, "lastName")
    }
    
    func testShowMapActionNavigatesToMap() {
        navigator.navigateToMapMock.expect(count: .toBeZero)
        let _ = try! viewModel.showMap.execute(()).toBlocking().single()!
        navigator.navigateToMapMock.expect(count: .toBeOne)
    }
    
    override func setUp() {
        super.setUp()
        provider = UserProviderMock()
        useCase = GetUserUseCase(provider: provider)
        navigator = UserNavigatorMock()
        viewModel = UserViewModel(useCase: useCase, navigator: navigator)
    }
    
    override func tearDown() {
        super.tearDown()
        provider = nil
        useCase = nil
        navigator = nil
        viewModel = nil
    }
}

class UserProviderMock: UseCase.UserProvider {
    let getUserMock = Mock(Single<User>.just(User(firstName: "firstName", lastName: "lastName")))
    func getUser() -> Single<User> {
        return getUserMock.execute()
    }
}

class UserNavigatorMock: UserNavigator {
    let navigateToMapMock = Mock(())
    func navigateToMap() {
        return navigateToMapMock.execute()
    }
}

