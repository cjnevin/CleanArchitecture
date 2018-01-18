import Foundation
import Model
import UseCase
import RxSwift

public protocol UserLocationView: BaseView {
    func showLocation(_ location: Location)
}

public class UserLocationPresenter<T: UserLocationView>: BasePresenter<T> {
    private let useCase: GetUserLocationUseCase
    private let workerScheduler: ImmediateSchedulerType
    private let mainScheduler: ImmediateSchedulerType
    
    public init(useCase: GetUserLocationUseCase,
                workerScheduler: ImmediateSchedulerType = ConcurrentDispatchQueueScheduler(qos: .background),
                mainScheduler: ImmediateSchedulerType = ConcurrentMainScheduler.instance) {
        self.useCase = useCase
        self.workerScheduler = workerScheduler
        self.mainScheduler = mainScheduler
    }
    
    public override func attachView(_ newView: T) {
        super.attachView(newView)
        
        disposeOnViewDetach(useCase.getLocation()
            .subscribeOn(workerScheduler)
            .observeOn(mainScheduler)
            .subscribe(onNext: newView.showLocation))
    }
}
