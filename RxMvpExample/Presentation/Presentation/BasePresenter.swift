import Foundation
import RxSwift

public class Presenter<T> {
    public typealias View = T
    private var disposeBag = DisposeBag()
    private var view: View?

    public func attachView(_ newView: View) {
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
