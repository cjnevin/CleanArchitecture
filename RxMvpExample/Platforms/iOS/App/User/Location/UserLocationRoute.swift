import Presentation
import RxSwift

struct UserLocationRoute: Route {
    let source: Route?
    let path: String = "location"
    let uniqueId: String = UUID().uuidString

    func navigate(animated: Bool) -> Completable {
        guard let navigator = (source as? NavigatorHaving)?.navigator.shownView as? Navigator else {
            return .error(NavigationError.incorrectConfiguration)
        }
        return navigator.show(UserLocationViewFactory().makeUserLocationView(),
                with: PushNavigationMode(animated: animated))
    }
}
