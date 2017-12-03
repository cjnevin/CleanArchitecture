import Foundation

public protocol OneWayTransformer {
    associatedtype FromType
    associatedtype ToType

    func transform(_ object: FromType) -> ToType
}
