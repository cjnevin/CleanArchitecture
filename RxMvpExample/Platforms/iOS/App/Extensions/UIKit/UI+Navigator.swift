import UIKit
import Presentation
import RxSwift

struct RootNavigationMode: NavigationMode {
    let animated: Bool
}
struct PushNavigationMode: NavigationMode {
    let animated: Bool
}
struct ModalNavigationMode: NavigationMode {
    let animated: Bool
}

protocol NavigationMode {
    var animated: Bool { get }
}

protocol Viewable { }
extension UIViewController: Viewable { }

protocol Navigator {
    var shownView: Viewable? { get }
    func show(_ view: Viewable, with mode: NavigationMode) -> Completable
}

extension UIWindow: Navigator {
    var shownView: Viewable? {
        return rootViewController?.presentedViewController ?? rootViewController
    }

    func show(_ view: Viewable, with mode: NavigationMode) -> Completable {
        let _view = view as! UIViewController
        if mode is RootNavigationMode {
            self.rootViewController = _view
            self.makeKeyAndVisible()
            return .empty()
        } else if mode is ModalNavigationMode {
            return Completable.create { observer in
                self.rootViewController?.present(_view, animated: mode.animated) {
                    observer(.completed)
                }
                return Disposables.create()
            }
        } else {
            return .error(NavigationError.navigationModeUnsupported)
        }
    }
}

extension UINavigationController: Navigator {
    var shownView: Viewable? {
        guard let presented = presentedViewController else {
            return viewControllers.last
        }
        return presented
    }

    private func pushViewController(_ viewController: UIViewController,
                                    animated: Bool,
                                    completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }

    func show(_ view: Viewable, with mode: NavigationMode) -> Completable {
        let _view = view as! UIViewController
        if mode is PushNavigationMode {
            return Completable.create { observer in
                self.pushViewController(_view, animated: mode.animated) {
                    observer(.completed)
                }
                return Disposables.create()
            }
        } else if mode is ModalNavigationMode {
            return Completable.create { observer in
                self.present(_view, animated: mode.animated) {
                    observer(.completed)
                }
                return Disposables.create()
            }
        } else {
            return .error(NavigationError.navigationModeUnsupported)
        }
    }
}

extension UITabBarController: Navigator {
    var shownView: Viewable? {
        return self
    }

    private func addViewController(_ viewController: UIViewController,
                                   animated: Bool,
                                   completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let newViewControllers = (viewControllers ?? []) + [viewController]
        setViewControllers(newViewControllers, animated: animated)
        CATransaction.commit()
    }

    func show(_ view: Viewable, with mode: NavigationMode) -> Completable {
        let _view = view as! UIViewController
        if mode is RootNavigationMode {
            return Completable.create { observer in
                self.addViewController(_view, animated: mode.animated) {
                    observer(.completed)
                }
                return Disposables.create()
            }
        } else {
            return .error(NavigationError.navigationModeUnsupported)
        }
    }
}

protocol NavigatorHaving {
    var navigator: Navigator { get }
}

enum NavigationError: Swift.Error {
    case incorrectConfiguration
    case navigationModeUnsupported
}
