import Foundation
import CoreLocation
import Entity

public struct LocationCLLocationTransformer: TwoWayTransformer {
    public typealias TypeA = CLLocation
    public typealias TypeB = Location
    
    public init() { }
    
    public func transform(_ object: CLLocation) -> Location {
        return Location(latitude: object.coordinate.latitude,
                        longitude: object.coordinate.longitude)
    }
    
    public func transform(_ object: Location) -> CLLocation {
        return CLLocation(latitude: object.latitude,
                          longitude: object.longitude)
    }
}
