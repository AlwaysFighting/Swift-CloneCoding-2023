import UIKit
import FirebaseAuth

class MainViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let email = Auth.auth().currentUser?.email ?? "고객"
        self.welcomeLabel.text = "환영합니다.\(email)님"
        
        let isEmailSignIn = Auth.auth().currentUser?.providerData[0].providerID == "password"
        resetPasswordButton.isHidden = !isEmailSignIn
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popViewController(animated: true)
        } catch  let signOutError as NSError {
            print("ERROR : SignOut \(signOutError.localizedDescription)")
        }
    }
    
    @IBAction func resetPasswordButtonTapped(_ sender: UIButton) {
        let email = Auth.auth().currentUser?.email ?? ""
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("비밀번호 재설정 이메일 전송 에러:", error.localizedDescription)
            } else {
                print("비밀번호 재설정 이메일이 성공적으로 전송되었습니다.")
            }
        }
    }
}
