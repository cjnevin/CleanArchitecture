import UIKit

class AppNavigator {
    weak var window: UIWindow? {
        didSet {
            if window != nil {
                begin()
            }
        }
    }

    private func begin() {
        let userViewFactory = UserViewFactory()
        window?.rootViewController = userViewFactory.makeUserView()
        window?.makeKeyAndVisible()
    }
}
