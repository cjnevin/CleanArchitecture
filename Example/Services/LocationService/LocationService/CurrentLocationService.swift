import Foundation
import DataProvider
import Entity
import DataTransformer
import CoreLocation

public class CurrentLocationService: DataProvider.LocationService {
    private let transformer: LocationCLLocationTransformer
    private let locationManager: CLLocationManager
    private let locationManagerDelegate: LocationManagerDelegate
    private var latestLocation: CLLocation?
    
    public init(transformer: LocationCLLocationTransformer) {
        self.transformer = transformer
        self.locationManager = CLLocationManager()
        self.locationManagerDelegate = LocationManagerDelegate()
        self.locationManager.delegate = self.locationManagerDelegate
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
    }
    
    public func getCurrentLocation() -> Location {
        let fallbackLocation = CLLocation(latitude: 51.48, longitude: 0)
        let location = locationManager.location ?? fallbackLocation
        return transformer.transform(location)
    }
}

private class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
