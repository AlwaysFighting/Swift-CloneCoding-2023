import UIKit

protocol SendDateDelegate : AnyObject {
    func sendData(name: String)
}

class ViewController: UIViewController, LEDBoardSettingDelegate {
    
    func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor) {
        if let text = text {
            self.contentsLabel.text = text
        }
        self.contentsLabel.textColor = textColor
        self.view.backgroundColor = backgroundColor
    }
    
    @IBOutlet weak var contentsLabel: UILabel!
    
    weak var delegate: SendDateDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentsLabel.textColor = .yellow
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingVC = segue.destination as? SettingVC {
            settingVC.delegate = self
            settingVC.ledText = self.contentsLabel.text
            settingVC.textColor = self.contentsLabel.textColor
            settingVC.backgroundColor = self.view.backgroundColor ?? .black
        }
    }

}

