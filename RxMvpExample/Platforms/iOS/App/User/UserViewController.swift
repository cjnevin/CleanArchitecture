import UIKit
import Presentation
import RxSwift
import RxCocoa
import SnapKit
import Model

class UserViewController: UIViewController, UserView {
    private lazy var showMapButton: UIButton = makeShowMapButton()
    private lazy var firstNameTitleLabel: UILabel = makeFirstNameTitleLabel()
    private lazy var firstNameValueLabel: UILabel = makeFirstNameValueLabel()
    private lazy var lastNameTitleLabel: UILabel = makeLastNameTitleLabel()
    private lazy var lastNameValueLabel: UILabel = makeLastNameValueLabel()
    private lazy var nameStackView: UIStackView = makeNameStackView()
    
    var presenter: UserPresenter<UserViewController>?

    func showUser(_ user: User) {
        firstNameValueLabel.attributedText = Style.attributedValue(for: user.firstName)
        lastNameValueLabel.attributedText = Style.attributedValue(for: user.lastName)
    }
    
    func showError(_ error: Error) {
        print(error)
    }

    var showMapTrigger: Observable<Void> {
        return showMapButton.rx.tap.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        presenter?.attachView(self)
    }

    deinit {
        presenter?.detachView()
    }
    
    private func layout() {
        navigationItem.title = String.localize(Identifier.screenTitle)
        view.backgroundColor = Style.backgroundColor
        
        layoutNameStackView()
        layoutShowMapButton()
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
        let id = Identifier.showMap
        let button = UIButton(type: .custom)
        button.backgroundColor = Style.buttonBackgroundColor
        let localizedText = String.localize(id)
        button.setAttributedTitle(Style.attributedButtonTitle(for: localizedText), for: .normal)
        button.setAccessibility(identifier: id, value: localizedText)
        return button
    }

    private func makeLabel(with id: Identifier) -> UILabel {
        let label = UILabel()
        let localizedText = String.localize(id)
        let hasLocalizedText = localizedText != id.rawValue
        if hasLocalizedText {
            label.attributedText = Style.attributedTitle(for: localizedText)
            label.setAccessibility(identifier: id, value: localizedText)
        } else {
            label.setAccessibility(identifier: id)
        }
        return label
    }
    
    private func makeFirstNameTitleLabel() -> UILabel {
        return makeLabel(with: Identifier.firstNameTitle)
    }

    private func makeLastNameTitleLabel() -> UILabel {
        return makeLabel(with: Identifier.lastNameTitle)
    }

    private func makeFirstNameValueLabel() -> UILabel {
        return makeLabel(with: Identifier.firstNameValue)
    }

    private func makeLastNameValueLabel() -> UILabel {
        return makeLabel(with: Identifier.lastNameValue)
    }

    private func makeFirstNameStackView() -> UIStackView {
        return .makeHorizontalStackView(subviews: firstNameTitleLabel, firstNameValueLabel)
    }

    private func makeLastNameStackView() -> UIStackView {
        return .makeHorizontalStackView(subviews: lastNameTitleLabel, lastNameValueLabel)
    }

    private func makeNameStackView() -> UIStackView {
        return .makeVerticalStackView(subviews: makeFirstNameStackView(), makeLastNameStackView())
    }
}

private enum Identifier: String {
    case firstNameTitle = "user.first.name.title"
    case lastNameTitle = "user.last.name.title"
    case firstNameValue = "user.first.name.value"
    case lastNameValue = "user.last.name.value"
    case screenTitle = "user.screen.title"
    case showMap = "user.show.map"
}

private enum Style {
    static var backgroundColor: UIColor {
        return UIColor.white
    }
    
    static var buttonBackgroundColor: UIColor {
        return UIColor.blue.withAlphaComponent(0.05)
    }
    
    static func attributedButtonTitle(`for` string: String) -> NSAttributedString {
        return NSAttributedString(string: string, attributes: [
            .foregroundColor: UIColor.blue,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ])
    }
    
    static func attributedTitle(`for` string: String) -> NSAttributedString {
        return NSAttributedString(string: string, attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ])
    }
    
    static func attributedValue(`for` string: String) -> NSAttributedString {
        return NSAttributedString(string: string, attributes: [
            .foregroundColor: UIColor.blue
        ])
    }
}
