import Foundation
import DataProvider
import CoreLocation

extension CLLocation {
    func asDto() -> LocationDto {
        return LocationDto(latitude: coordinate.latitude,
                           longitude: coordinate.longitude)
    }
}

extension LocationDto {
    func asCLLocation() -> CLLocation {
        return CLLocation(latitude: latitude,
                          longitude: longitude)
    }
}
