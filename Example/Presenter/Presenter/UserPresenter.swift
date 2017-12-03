import Foundation
import Entity
import UseCase

public protocol UserView: class {
    func show(user: User)
}

public protocol UserNavigator {
    func navigateToUserLocation()
}

public class UserPresenter {
    public weak var view: UserView? = nil {
        didSet {
            if view != nil {
                begin()
            }
        }
    }
    private let navigator: UserNavigator
    private let useCase: GetUserUseCase
    
    public init(useCase: GetUserUseCase,
         navigator: UserNavigator) {
        self.navigator = navigator
        self.useCase = useCase
    }
    
    func begin() {
        let User = useCase.getUser()
        view?.show(user: User)
    }
    
    public func showLocation() {
        navigator.navigateToUserLocation()
    }
}
