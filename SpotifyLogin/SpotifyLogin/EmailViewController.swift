import UIKit
import FirebaseAuth

class EmailViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.UI()
    }
    
    private func UI() {
        self.nextButton.isEnabled = false
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.emailTextField.becomeFirstResponder()
    }
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        // Firebase 이메일/비번 인증
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007:
                    // 이미 가입한 계정일 경우
                    self.loginUser(withEmail: email, password: password)
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                }
            } else {
                self.showMainViewController()
            }
        }
    }
    
    private func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        }
    }
    
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
}

extension EmailViewController : UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let isEmailEmpty = self.emailTextField.text?.isEmpty else { return }
        guard let isPasswordEmpty = self.passwordTextField.text?.isEmpty else { return }
        
        self.nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
}
