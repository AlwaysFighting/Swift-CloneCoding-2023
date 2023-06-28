import UIKit

@IBDesignable
class LoginButton: UIButton {
    
    @IBInspectable var loginButtonStyle: Bool = false {
        didSet {
            if loginButtonStyle {
                self.layer.cornerRadius = CGFloat(30.0)
                self.layer.borderWidth = 1
                self.layer.borderColor = UIColor.white.cgColor
            }
        }
    }
}
