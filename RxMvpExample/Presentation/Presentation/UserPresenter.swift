import Foundation
import Model
import UseCase
import RxSwift

public protocol UserView {
    func showUser(_ user: User)
    func showError(_ error: Error)
    
    var showMapTrigger: Observable<Void> { get }
}

public class UserPresenter<T: UserView>: Presenter<T> {
    private let pathToMap = "location"
    private let route: Route
    private weak var wireframe: Wireframe?

    private let useCase: GetUserUseCase
    private let workerScheduler: ImmediateSchedulerType
    private let mainScheduler: ImmediateSchedulerType
    
    public init(route: Route,
                wireframe: Wireframe,
                useCase: GetUserUseCase,
                workerScheduler: ImmediateSchedulerType = ConcurrentDispatchQueueScheduler(qos: .background),
                mainScheduler: ImmediateSchedulerType = ConcurrentMainScheduler.instance) {
        self.wireframe = wireframe
        self.route = route
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
                .flatMap { [weak self] _ -> Observable<Never> in
                    guard let `self` = self, let wireframe = self.wireframe else {
                        return .empty()
                    }
                    return wireframe.navigate(from: self.route, to: self.pathToMap, animated: true)
                            .asObservable()
                }
                .subscribe())
    }
}
