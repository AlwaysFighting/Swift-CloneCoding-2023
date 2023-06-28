import UIKit
import FirebaseRemoteConfig
import FirebaseAnalytics

class ViewController: UIViewController {
    
    var remoteConfig: RemoteConfig?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        remoteConfig = RemoteConfig.remoteConfig()
        
        let setting = RemoteConfigSettings()
        // Test 를 위해서 인터벌을 통해서 최대한 자주 데이터를 가져올 수 있도록 한다.
        setting.minimumFetchInterval = 0
        
        remoteConfig?.configSettings = setting
        // 생성한 Property List 이름을 이 함수 안에 적는다.
        remoteConfig?.setDefaults(fromPlist: "RemoteConfigDefaults")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getNotice()
    }

}

// RemoteConfig
extension ViewController {
    private func getNotice() {
        guard let remoteConfig = remoteConfig else { return }
        
        remoteConfig.fetch { [weak self] status, _ in
            if status == .success {
                remoteConfig.activate()
            } else {
                print("ERROR : Config not fetched")
            }
            
            guard let self = self else { return }
            
            if !self.isNoticeHidden(remoteConfig) {
                let noticeVC = NoticeViewController(nibName: "NoticeViewController", bundle: nil)
                
                noticeVC.modalPresentationStyle = .custom
                noticeVC.modalTransitionStyle = .crossDissolve
                
                let title = (remoteConfig["title"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                let detail = (remoteConfig["detail"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                let date = (remoteConfig["date"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                
                noticeVC.noticeContents = (title: title, detail: detail, date: date)
                self.present(noticeVC, animated: true)
            } else {
                self.showEventAlert()
            }
        }
    }
    
    private func isNoticeHidden( _ remoteConfig: RemoteConfig) -> Bool {
        return remoteConfig["isHidden"].boolValue
    }
}

// A/B Testing
extension ViewController {
    private func showEventAlert() {
        guard let remoteConfig = remoteConfig else { return }
        
        remoteConfig.fetch { [weak self] status, _ in
            if status == .success {
                remoteConfig.activate()
            } else {
                print("Config not fetched")
            }
            
            let message = remoteConfig["message"].stringValue ?? ""
            let confrimAction = UIAlertAction(title: "확인하기", style: .default) { _ in
                // Google Analytis (버튼을 눌릴 때마다 이벤트를 기록할 것임)
                Analytics.logEvent("promotion_alert", parameters: nil)
            }
            
            let cancleAction = UIAlertAction(title: "취소", style: .default, handler: nil)
            let alretController = UIAlertController(title: "깜짝이벤트", message: message, preferredStyle: .alert)
        
            alretController.addAction(confrimAction)
            alretController.addAction(cancleAction)
            
            self?.present(alretController, animated: true)
        }
    }
}
