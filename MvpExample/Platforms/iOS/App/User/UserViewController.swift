import UIKit
import Entity
import Presenter

class UserViewController: UIViewController, UserView {
    private lazy var showMapButton: UIButton = makeShowMapButton()
    private lazy var firstNameTitleLabel: UILabel = makeFirstNameTitleLabel()
    private lazy var firstNameValueLabel: UILabel = makeFirstNameValueLabel()
    private lazy var lastNameTitleLabel: UILabel = makeLastNameTitleLabel()
    private lazy var lastNameValueLabel: UILabel = makeLastNameValueLabel()
    private lazy var nameStackView: UIStackView = makeNameStackView()
    
    var presenter: UserPresenter? {
        didSet {
            presenter?.view = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
    }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

    private func layout() {
        navigationItem.title = "User Details"
        
        view.backgroundColor = .white
        view.addManuallyAnchoredSubview(showMapButton)
        view.addManuallyAnchoredSubview(nameStackView)
        
        NSLayoutConstraint.activate([
            nameStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nameStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameStackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2),
            
            showMapButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            showMapButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            showMapButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            showMapButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2)
            ])
    }
    
    private func bind() {
        showMapButton.addTarget(self, action: #selector(showMap), for: .touchUpInside)
    }
    
    @objc func showMap(_ sender: UIButton) {
        presenter?.showLocation()
    }
	
    func show(user: User) {
        firstNameValueLabel.text = user.firstName
        lastNameValueLabel.text = user.lastName
    }
}

private extension UIView {
    func addManuallyAnchoredSubview(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
    }
}

private extension UILabel {
	static func makeTitleLabel(with text: String? = nil) -> UILabel {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 14)
		label.textColor = .black
		label.text = text
		return label
	}
	
	static func makeValueLabel() -> UILabel {
		let label = UILabel()
		label.textColor = .blue
		return label
	}
}

private extension UIStackView {
	static func makeHorizontalStackView(with views: UIView...) -> UIStackView {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.spacing = 20
		views.forEach(stackView.addArrangedSubview)
		return stackView
	}
	
	static func makeVerticalStackView(with views: UIView...) -> UIStackView {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 20
		views.forEach(stackView.addArrangedSubview)
		return stackView
	}
}

private extension UserViewController {
    private func makeShowMapButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.blue.withAlphaComponent(0.05)
        button.setTitle("Show Map", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }
	
    private func makeFirstNameTitleLabel() -> UILabel {
		return UILabel.makeTitleLabel(with: "First Name:")
    }
    
    private func makeLastNameTitleLabel() -> UILabel {
		return UILabel.makeTitleLabel(with: "Last Name:")
    }
    
    private func makeFirstNameValueLabel() -> UILabel {
		return UILabel.makeValueLabel()
    }
    
    private func makeLastNameValueLabel() -> UILabel {
        return UILabel.makeValueLabel()
    }
    
    private func makeFirstNameStackView() -> UIStackView {
		return UIStackView.makeHorizontalStackView(with: firstNameTitleLabel, firstNameValueLabel)
    }
    
    private func makeLastNameStackView() -> UIStackView {
		return UIStackView.makeHorizontalStackView(with: lastNameTitleLabel, lastNameValueLabel)
    }
    
    private func makeNameStackView() -> UIStackView {
		return UIStackView.makeVerticalStackView(with: makeFirstNameStackView(), makeLastNameStackView())
    }
}
