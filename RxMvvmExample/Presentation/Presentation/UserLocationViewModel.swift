import Foundation
import Model
import UseCase
import RxCocoa
import RxSwift

public class UserLocationViewModel: ReactiveCompatible {
    fileprivate let useCase: GetUserLocationUseCase

    public init(useCase: GetUserLocationUseCase) {
        self.useCase = useCase
    }
}

public extension Reactive where Base: UserLocationViewModel {
    public func location() -> Driver<Location> {
        return base.useCase.getLocation()
                .asDriver(onErrorDriveWith: .empty())
    }
}
