import Foundation

public struct Location {
    public let latitude: Double
    public let longitude: Double

    public init(latitude: Double,
                longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
