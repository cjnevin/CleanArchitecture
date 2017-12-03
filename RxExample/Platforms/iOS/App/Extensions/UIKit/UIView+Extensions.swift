import UIKit

extension UIView {
	func addManuallyAnchoredSubview(_ subview: UIView) {
		subview.translatesAutoresizingMaskIntoConstraints = false
		addSubview(subview)
	}
}
