import Foundation
import DataProvider
import Model
import CoreLocation
import RxSwift

public class CurrentLocationService: DataProvider.LocationService {
    private let transformer: LocationCLLocationTransformer
    private let locationManager: CLLocationManager
    private let locationManagerDelegate: LocationManagerDelegate

    public init() {
        self.transformer = LocationCLLocationTransformer()
        self.locationManager = CLLocationManager()
        self.locationManagerDelegate = LocationManagerDelegate()
        self.locationManager.delegate = self.locationManagerDelegate
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
    }

    public func getCurrentLocation() -> Observable<Location> {
        return locationManagerDelegate
                .latestLocation
                .asObservable()
                .map(transformer.transform)
    }
}

private let fallbackLocation = CLLocation(latitude: 51.48, longitude: 0)

private class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    var latestLocation = Variable<CLLocation>(fallbackLocation)

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        latestLocation.value = manager.location ?? fallbackLocation
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

    }
}
