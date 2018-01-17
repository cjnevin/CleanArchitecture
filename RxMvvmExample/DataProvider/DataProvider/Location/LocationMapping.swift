import Foundation
import Model

public struct LocationDto {
    public let latitude: Double
    public let longitude: Double
    
    public init(latitude: Double,
                longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension LocationDto {
    func asModel() -> Location {
        return Location(latitude: latitude,
                        longitude: longitude)
    }
}

extension Location {
    func asDto() -> LocationDto {
        return LocationDto(latitude: latitude,
                           longitude: longitude)
    }
}
