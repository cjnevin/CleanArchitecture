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
        let wireframe = UserViewFactory()
        window?.rootViewController = wireframe.makeUserView()
        window?.makeKeyAndVisible()
    }
}
