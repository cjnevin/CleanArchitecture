import Foundation
import DataProvider
import CoreLocation
import RxSwift

public class CurrentLocationService: DataProvider.LocationService {
    private let locationManager: CLLocationManager
    private let locationManagerDelegate: LocationManagerDelegate

    public init() {
        self.locationManager = CLLocationManager()
        self.locationManagerDelegate = LocationManagerDelegate()
        self.locationManager.delegate = self.locationManagerDelegate
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
    }

    public func getCurrentLocation() -> Observable<LocationDto> {
        return locationManagerDelegate
                .latestLocation
                .asObservable()
                .map { $0.asDto() }
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
