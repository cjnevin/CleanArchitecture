import UIKit

extension UIView {
    func setAccessibility<T: RawRepresentable>(identifier: T?, value: String? = nil, hint: String? = nil) where T.RawValue == String {
        self.isAccessibilityElement = true
        if let identifier = identifier {
            self.accessibilityIdentifier = identifier.rawValue
        }
        if let value = value {
            self.accessibilityValue = value
        }
        if let hint = hint {
            self.accessibilityHint = hint
        }
    }
}
