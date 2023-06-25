import UIKit
import AudioToolbox

enum TimeStatus {
    case start
    case pause
    case end
}

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var toggleButton: UIButton!
    
    // 타이머를 초로 저장하는 변수
    var duration = 60
    var timerStatus : TimeStatus = .end
    var timer : DispatchSourceTimer?
    var currentSeconds = 0 // 현재 카운트다운하고 있는 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureToggleButton()
    }
    
    @IBAction func tapCancelButton(_ sender: UIButton) {
        switch self.timerStatus {
        case .start, .pause :
            self.stopTimer()
        default:
            break
        }
    }
    
    @IBAction func tapToggleButton(_ sender: UIButton) {
        // datePicker 에서 설정한 것을 초로 가져올 수 있다.
        self.duration = Int(self.datePicker.countDownDuration)
        switch self.timerStatus {
        case .end:
            self.currentSeconds = self.duration
            self.timerStatus = .start
            UIView.animate(withDuration: 0.5, animations: {
                self.timerLabel.alpha = 1
                self.progressView.alpha = 1
                self.datePicker.alpha = 0
            })
            self.toggleButton.isSelected = true
            self.cancelButton.isEnabled = true
            self.startTimer()
        case .start:
            self.timerStatus = .pause
            self.toggleButton.isSelected = false
            self.timer?.suspend() // 일시정지
        case .pause:
            self.timerStatus = .start
            self.toggleButton.isSelected = true
            self.timer?.resume()
        default:
            break
        }
    }
    
    func setTimerInfoViewVisible(isHidden: Bool) {
        self.timerLabel.isHidden = isHidden
        self.progressView.isHidden = isHidden
    }
    
    func configureToggleButton() {
        self.toggleButton.setTitle("시작", for: .normal)
        self.toggleButton.setTitle("일시정지", for: .selected)
    }
    
    func startTimer() {
        if self.timer == nil {
            // ⭐️ 인터페이스와 관련된 작업(UI)은 무조건 main 스레드에서 처리해야 한다.
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            // deadline 는 타이머를 언제 시작할 것인지 (지금? 3초후:), repeating 은 몇 초마다 실행하게 해줄 것인지
            self.timer?.schedule(deadline: .now(), repeating: 1)
            self.timer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                self.currentSeconds -= 1
                let hour = self.currentSeconds / 3600 // 시
                let minute = (self.currentSeconds % 3600) / 60 // 분
                let seconds = (self.currentSeconds % 3600) % 60 // 초
                
                // 숫자를 2자리로 제한하고 3개를 작성해서 15초 형식으로 작성한다
                self.timerLabel.text = String(format: "%02d:%02d:%02d", hour, minute, seconds)
                
                self.progressView.progress = Float(self.currentSeconds) / Float(self.duration)
                
                UIView.animate(withDuration: 0.5, delay: 0, animations: {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
                })
                UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi * 2)
                })
                
                if self.currentSeconds ?? 0 <= 0 {
                    // 타이머가 종료된다.
                    self.stopTimer()
                    AudioServicesPlaySystemSound(1005)
                }
            })
            self.timer?.resume()
        }
    }
    
    func stopTimer() {
        if self.timerStatus == .pause {
            self.timer?.resume()
        }
        self.timerStatus = .end
        self.cancelButton.isEnabled = false
        UIView.animate(withDuration: 0.5, animations: {
            self.timerLabel.alpha = 0
            self.progressView.alpha = 0
            self.datePicker.alpha = 1
            self.imageView.transform = .identity // 이미지를 원상태로 되돌리기
        })
        self.toggleButton.isSelected = false
        self.timer?.cancel()
        self.timer = nil // 메모리에서 해제! ⭐️ 안그러면 화면을 넘어가도 타이머가 진행할 수 있기 때문이다.
    }
    
}

