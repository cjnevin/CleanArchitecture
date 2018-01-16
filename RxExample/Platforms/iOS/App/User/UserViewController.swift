import UIKit
import Presentation
import RxSwift
import RxCocoa
import SnapKit

class UserViewController: UIViewController {
    private lazy var showMapButton: UIButton = makeShowMapButton()
    private lazy var firstNameTitleLabel: UILabel = makeFirstNameTitleLabel()
    private lazy var firstNameValueLabel: UILabel = makeFirstNameValueLabel()
    private lazy var lastNameTitleLabel: UILabel = makeLastNameTitleLabel()
    private lazy var lastNameValueLabel: UILabel = makeLastNameValueLabel()
    private lazy var nameStackView: UIStackView = makeNameStackView()
    private lazy var singleDisposable = SingleAssignmentDisposable()

    var viewModel: UserViewModel? {
        didSet {
            singleDisposable.dispose()

            if let viewModel = viewModel {
                singleDisposable.setDisposable(
                    bind(viewModel)
                )
            }
        }
    }

    private func bind(_ viewModel: UserViewModel) -> Disposable {
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
        
        layoutNameStackView()
        layoutShowMapButton()
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
    private var layoutGuide: UILayoutGuide {
        return view.safeAreaLayoutGuide
    }
    
    private func layoutNameStackView() {
        view.addSubview(nameStackView)
        nameStackView.snp.makeConstraints { make in
            make.leading.top.equalTo(layoutGuide).offset(20)
            make.trailing.equalTo(layoutGuide).offset(-20)
            make.height.equalTo(layoutGuide.snp.height).multipliedBy(0.2)
        }
    }
    
    private func layoutShowMapButton() {
        view.addSubview(showMapButton)
        showMapButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(layoutGuide)
            make.height.equalTo(layoutGuide.snp.height).multipliedBy(0.2)
        }
    }
    
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
