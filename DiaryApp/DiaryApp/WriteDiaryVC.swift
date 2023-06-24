import UIKit

enum DiaryEditorMode {
    case new
    case edit(IndexPath, Diary)
}

protocol WriteDiaryViewDelegate: AnyObject {
    func didSelectRegister(diary: Diary)
}

class WriteDiaryVC: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var confirmBtn: UIBarButtonItem!
    
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    weak var delegate: WriteDiaryViewDelegate?
    var diaryEditorMode: DiaryEditorMode = .new
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureContentsTextView()
        self.configureDatePicker()
        self.configureInputField()
        self.configureEditorMode()
        self.confirmBtn.isEnabled = false
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    private func configureEditorMode() {
        switch self.diaryEditorMode {
        case let .edit(_, diary):
            self.titleTextField.text = diary.title
            self.contentsTextView.text = diary.contents
            self.dateTextField.text = dateToString(date: diary.date)
            self.diaryDate = diary.date
            self.confirmBtn.title = "수정"
        default:
            break
        }
    }
    
    private func configureInputField() {
        self.contentsTextView.delegate = self
        self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        self.dateTextField.addTarget(self, action: #selector(dateTextFieldDidChanged(_:)), for: .editingChanged)
    }
    
    private func configureContentsTextView() {
        let borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        self.contentsTextView.layer.borderColor = borderColor.cgColor
        self.contentsTextView.layer.borderWidth = 0.5
        self.contentsTextView.layer.cornerRadius = 5.0
    }
    
    private func configureDatePicker() {
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange), for: .valueChanged)
        self.datePicker.locale = Locale(identifier: "ko_KR")
        self.dateTextField.inputView = self.datePicker
    }
    
    private func validateInputField() {
        self.confirmBtn.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.dateTextField.text?.isEmpty ?? true) && !(self.contentsTextView.text?.isEmpty ?? true)
    }
    
    @IBAction func tapConfirmBtn(_ sender: UIBarButtonItem) {
        guard let title = self.titleTextField.text  else { return }
        guard let contents = self.contentsTextView.text else { return }
        guard let date = self.diaryDate else { return }
        let diary = Diary(title: title, contents: contents, date: date, isStar: false)
        
        switch self.diaryEditorMode {
        case .new:
            self.delegate?.didSelectRegister(diary: diary)
        case let .edit(IndexPath, _) :
            NotificationCenter.default.post(name: NSNotification.Name("editDiary"), object: diary,
                                            userInfo: [
                                                "indexPath" : IndexPath.row
                                            ]
            )
        default:
            break
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func dateTextFieldDidChanged(_ textField: UITextField) {
        self.validateInputField()
    }
    
    @objc private func titleTextFieldDidChange(_ textField: UITextField) {
        self.validateInputField()
    }
    
    @objc private func datePickerValueDidChange(_ datepicker: UIDatePicker) {
        let formatter = DateFormatter() // 날짜와 텍스트를 받아준다. (사람이 읽을 수 있게 변환해주는)
        formatter.dateFormat = "yyyy 년 MM 월 dd 일(EEEEE)" // EEEEE 는 월,화 처럼 한 글자로 변환해준다.
        formatter.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datepicker.date
        self.dateTextField.text = formatter.string(from: datepicker.date)
        self.dateTextField.sendActions(for: .editingChanged)
    }
    
    // 빈화면을 누를 때마다 호출되는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension WriteDiaryVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
    }
}
