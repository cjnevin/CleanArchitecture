import UIKit
import Model
import MapKit
import Presentation
import RxSwift
import SnapKit

class UserLocationViewController: UIViewController, UserLocationView {
    private lazy var mapView: MKMapView = MKMapView()
    
    var presenter: UserLocationPresenter<UserLocationViewController>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        presenter?.attachView(self)
    }
    
    deinit {
        presenter?.detachView()
    }

    private func layout() {
        navigationItem.title = "User Location"
        view.backgroundColor = .white
        
        layoutMapView()
    }
    
    func showLocation(_ location: Location) {
        mapView.setLocation(location)
    }
}

private extension UserLocationViewController {
    private func layoutMapView() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

private extension MKMapView {
    func setLocation(_ location: Location) {
        removeAnnotations(annotations.filter {
            $0 is MKPlacemark
        })
        addAnnotation(location.asPlacemark())
        centerCoordinate = location.asCoordinate()
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
