import UIKit

extension UIStackView {
    static func makeHorizontalStackView(with spacing: CGFloat = 20, subviews: UIView...) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = spacing
        subviews.forEach(stackView.addArrangedSubview)
        return stackView
    }

    static func makeVerticalStackView(with spacing: CGFloat = 20, subviews: UIView...) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = spacing
        subviews.forEach(stackView.addArrangedSubview)
        return stackView
    }
}
