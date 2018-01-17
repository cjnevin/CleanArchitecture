import Foundation
import Entity
import UseCase

public protocol UserLocationView: class {
    func show(location: Location)
}

public protocol UserLocationNavigator {
    
}

public class UserLocationPresenter {
    public weak var view: UserLocationView? = nil {
        didSet {
            if view != nil {
                begin()
            }
        }
    }
    private let navigator: UserLocationNavigator
    private let useCase: GetUserLocationUseCase
    
    public init(useCase: GetUserLocationUseCase,
                navigator: UserLocationNavigator) {
        self.navigator = navigator
        self.useCase = useCase
    }
    
    func begin() {
        let location = useCase.getLocation()
        view?.show(location: location)
    }
}
