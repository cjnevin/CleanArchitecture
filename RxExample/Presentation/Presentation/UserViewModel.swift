import Foundation
import Model
import UseCase
import RxCocoa
import RxSwift
import Action

public protocol UserNavigator {
    func navigateToMap()
}

public class UserViewModel: ReactiveCompatible {
    fileprivate let user: Driver<User>
    public let showMap: Action<Void, Void>

    public init(useCase: GetUserUseCase,
                navigator: UserNavigator) {
        self.user = useCase.getUser().asDriver(onErrorDriveWith: .empty())
        self.showMap = Action<Void, Void> { _ in
            .just(navigator.navigateToMap())
        }
    }
}

public extension Reactive where Base: UserViewModel {
    public var firstName: Driver<String> {
        return base.user.map {
            $0.firstName
        }
    }

    public var lastName: Driver<String> {
        return base.user.map {
            $0.lastName
        }
    }
}
