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
		let viewFactory = UserViewFactory()
        window?.rootViewController = viewFactory.makeUserView()
        window?.makeKeyAndVisible()
    }
}
