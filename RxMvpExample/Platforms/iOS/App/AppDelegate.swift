import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let navigator = AppNavigator()
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        navigator.window = window
        return true
    }
}
