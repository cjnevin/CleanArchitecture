import Foundation

public protocol TwoWayTransformer {
    associatedtype TypeA
    associatedtype TypeB
    
    func transform(_ object: TypeA) -> TypeB
    func transform(_ object: TypeB) -> TypeA
}
