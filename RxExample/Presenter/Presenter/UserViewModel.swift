import Foundation
import Entity
import UseCase
import RxCocoa
import RxSwift
import Action

public protocol UserNavigator {
    func navigateToMap()
}

public class UserViewModel: ReactiveCompatible {
    internal let useCase: GetUserUseCase
    public let showMap: Action<Void, Void>

    public init(useCase: GetUserUseCase,
                navigator: UserNavigator) {
        self.useCase = useCase
        self.showMap = Action<Void, Void> { _ in
            .just(navigator.navigateToMap())
        }
    }
}

public extension Reactive where Base: UserViewModel {
    internal func user() -> Driver<User> {
        return base.useCase.getUser().asDriver(onErrorDriveWith: .empty())
    }

    public var firstName: Driver<String> {
        return user().map {
            $0.firstName
        }
    }

    public var lastName: Driver<String> {
        return user().map {
            $0.lastName
        }
    }
}
