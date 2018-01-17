import UIKit
import Entity
import MapKit
import Presenter

class UserLocationViewController: UIViewController, UserLocationView {
    var presenter: UserLocationPresenter? {
        didSet {
            presenter?.view = self
        }
    }
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        navigationItem.title = "User Location"
        
        view.backgroundColor = .white
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    func show(location: Location) {
        mapView.addAnnotation(location.asPlacemark())
        mapView.centerCoordinate = location.asCoordinate()
    }
}

private extension Location {
    func asCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude,
                                      longitude: longitude)
    }
    
    func asPlacemark() -> MKPlacemark {
        return MKPlacemark(coordinate: asCoordinate())
    }
}
