import UIKit
import Entity
import MapKit
import Presenter
import RxSwift
import RxCocoa

class UserLocationViewController: UIViewController {
	private lazy var mapView: MKMapView = MKMapView()
	private lazy var singleDisposable = SingleAssignmentDisposable()
	
	var viewModel: UserLocationViewModel? {
		didSet {
			singleDisposable.dispose()
			
			if let viewModel = viewModel {
				singleDisposable.setDisposable(
					viewModel.rx.location()
						.drive(onNext: { [weak self] location in
							self?.mapView.setLocation(location)
						})
				)
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		layout()
	}
	
	private func layout() {
		navigationItem.title = "User Location"
		
		view.backgroundColor = .white
		view.addManuallyAnchoredSubview(mapView)
		
		NSLayoutConstraint.activate([
			mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			mapView.topAnchor.constraint(equalTo: view.topAnchor),
			mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
			])
	}
}

private extension MKMapView {
	func setLocation(_ location: Location) {
		removeAnnotations(annotations.filter { $0 is MKPlacemark })
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
