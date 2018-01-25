import Foundation
import RxSwift

public class Presenter<T> {
    public typealias View = T
    private var disposeBag = DisposeBag()
    private var view: View?
    private var subPresenters: [Presenter<T>] = []
    
    public func attachPresenter(_ presenter: Presenter<T>) {
        subPresenters.append(presenter)
    }
    
    public func attachView(_ newView: View) {
        assert(view == nil)
        view = newView
        subPresenters.forEach { $0.attachView(newView) }
    }

    public func detachView() {
        subPresenters.forEach { $0.detachView() }
        view = nil
        disposeBag = DisposeBag()
    }

    public func disposeOnViewDetach(_ disposable: Disposable) {
        subPresenters.forEach { $0.disposeOnViewDetach(disposable) }
        disposeBag.insert(disposable)
    }
}
