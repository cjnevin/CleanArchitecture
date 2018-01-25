import Foundation
import Model
import UseCase
import RxSwift

public protocol UserView {
    func showUser(_ user: User)
    func showError(_ error: Error)
    func showMap()
    
    var showMapTrigger: Observable<Void> { get }
}

public class UserPresenter<T: UserView>: Presenter<T> {
    private let useCase: GetUserUseCase
    private let workerScheduler: ImmediateSchedulerType
    private let mainScheduler: ImmediateSchedulerType
    
    public init(useCase: GetUserUseCase,
                workerScheduler: ImmediateSchedulerType = ConcurrentDispatchQueueScheduler(qos: .background),
                mainScheduler: ImmediateSchedulerType = ConcurrentMainScheduler.instance) {
        self.useCase = useCase
        self.workerScheduler = workerScheduler
        self.mainScheduler = mainScheduler
    }
    
    public override func attachView(_ newView: T) {
        super.attachView(newView)
        
        disposeOnViewDetach(useCase.getUser()
            .subscribeOn(workerScheduler)
            .observeOn(mainScheduler)
            .subscribe(onSuccess: { (user) in
                newView.showUser(user)
            }, onError: { error in
                newView.showError(error)
            }))
        
        disposeOnViewDetach(newView.showMapTrigger
            .subscribe(onNext: { _ in
                newView.showMap()
            }))
    }
}
