import UIKit
import Presentation
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let wireframe = Wireframe()
    private let disposeBag = DisposeBag()
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setup()
        return true
    }

    private func setup() {
        window = UIWindow(frame: UIScreen.main.bounds)

        let userRoute = UserRoute(navigator: window!, wireframe: wireframe)
        let userLocationRoute = UserLocationRoute(source: userRoute)

        wireframe.add(route: userRoute)
        wireframe.add(route: userLocationRoute)
        wireframe.navigate(to: "user/location", animated: false)
                .subscribe()
                .disposed(by: disposeBag)
    }
}
