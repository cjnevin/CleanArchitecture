import Foundation
import RxSwift

public protocol BaseView { }

public class BasePresenter<T: BaseView> {
    private var disposeBag = DisposeBag()
    private var view: T?
    
    public func attachView(_ newView: T) {
        assert(view == nil)
        view = newView
    }
    
    public func detachView() {
        view = nil
        disposeBag = DisposeBag()
    }
    
    public func disposeOnViewDetach(_ disposable: Disposable) {
        disposeBag.insert(disposable)
    }
}
