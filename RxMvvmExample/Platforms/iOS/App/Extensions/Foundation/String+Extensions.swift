import Foundation

extension String {
    static func localize<T: RawRepresentable>(_ id: T) -> String where T.RawValue == String {
        return NSLocalizedString(id.rawValue, comment: id.rawValue)
    }
}
