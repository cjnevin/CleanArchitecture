import UIKit
import Entity
import Presentation
import RxSwift
import RxCocoa

class UserViewController: UIViewController {
    private lazy var showMapButton: UIButton = makeShowMapButton()
    private lazy var firstNameTitleLabel: UILabel = makeFirstNameTitleLabel()
    private lazy var firstNameValueLabel: UILabel = makeFirstNameValueLabel()
    private lazy var lastNameTitleLabel: UILabel = makeLastNameTitleLabel()
    private lazy var lastNameValueLabel: UILabel = makeLastNameValueLabel()
    private lazy var nameStackView: UIStackView = makeNameStackView()
    private lazy var disposeBag = DisposeBag()

    var viewModel: UserViewModel? {
        didSet {
            disposeBag = DisposeBag()

            guard let viewModel = viewModel else {
                return
            }
            bind(viewModel: viewModel).disposed(by: disposeBag)
        }
    }

    private func bind(viewModel: UserViewModel) -> Disposable {
        showMapButton.rx.action = viewModel.showMap

        return CompositeDisposable(disposables: [
            viewModel.rx.firstName
                    .drive(firstNameValueLabel.rx.text),
            viewModel.rx.lastName
                    .drive(lastNameValueLabel.rx.text)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
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
        return UIStackView.makeHorizontalStackView(subviews: firstNameTitleLabel, firstNameValueLabel)
    }

    private func makeLastNameStackView() -> UIStackView {
        return UIStackView.makeHorizontalStackView(subviews: lastNameTitleLabel, lastNameValueLabel)
    }

    private func makeNameStackView() -> UIStackView {
        return UIStackView.makeVerticalStackView(subviews: makeFirstNameStackView(), makeLastNameStackView())
    }
}
