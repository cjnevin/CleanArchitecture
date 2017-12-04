import Foundation
import CoreLocation
import Entity

struct LocationCLLocationTransformer {
    func transform(_ object: CLLocation) -> Location {
        return Location(latitude: object.coordinate.latitude,
                longitude: object.coordinate.longitude)
    }

    func transform(_ object: Location) -> CLLocation {
        return CLLocation(latitude: object.latitude,
                longitude: object.longitude)
    }
}
