import UIKit

extension UIButton {

func applyMainButtonStyle() {
    setTitleColor(.white, for: .normal)
    titleLabel?.font = UIFont.futura()
    backgroundColor = UIColor.appBlue
    layer.borderColor = UIColor.gray.cgColor
    layer.borderWidth = 2
    layer.cornerRadius = 16
    clipsToBounds = true
}

}
