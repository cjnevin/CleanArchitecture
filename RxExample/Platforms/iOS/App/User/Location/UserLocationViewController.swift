import UIKit
import Model
import MapKit
import Presentation
import RxSwift
import RxCocoa
import SnapKit

class UserLocationViewController: UIViewController {
    private lazy var mapView: MKMapView = MKMapView()
    private lazy var singleDisposable = SingleAssignmentDisposable()

    var viewModel: UserLocationViewModel? {
        didSet {
            singleDisposable.dispose()
            
            if let viewModel = viewModel {
                singleDisposable.setDisposable(
                    bind(viewModel)
                )
            }
        }
    }
    
    private func bind(_ viewModel: UserLocationViewModel) -> Disposable {
        return viewModel.rx.location()
            .drive(mapView.rx.location)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    private func layout() {
        navigationItem.title = "User Location"
        view.backgroundColor = .white
        
        layoutMapView()
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

private extension Reactive where Base: MKMapView {
    var location: Binder<Location> {
        return Binder<Location>(self.base) { (view, location) -> () in
            view.removeAnnotations(view.annotations.filter {
                $0 is MKPlacemark
            })
            view.addAnnotation(location.asPlacemark())
            view.centerCoordinate = location.asCoordinate()
        }
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
