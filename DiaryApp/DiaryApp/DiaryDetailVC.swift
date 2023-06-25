import UIKit

class DiaryDetailVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var starBtn: UIBarButtonItem?
    
    var diary: Diary?
    var indexpath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        NotificationCenter.default.addObserver(self, selector: #selector(starDiaryNotification(_:)), name: NSNotification.Name("starDiary"), object: nil)
    }
    
    private func configureView() {
        guard let diary = self.diary else { return }
        self.titleLabel.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateLabel.text = dateToString(date: diary.date)
        
        self.starBtn = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(tapStarButton))
        self.starBtn?.image = diary.isStar ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        self.starBtn?.tintColor = .orange
        self.navigationItem.rightBarButtonItem = self.starBtn
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    @IBAction func tapEditBtn(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "WriteDiaryVC") as? WriteDiaryVC else { return }
        guard let indexpath = self.indexpath else { return }
        guard let diary = self.diary else { return }
        vc.diaryEditorMode = .edit(indexpath, diary)
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNotification), name: NSNotification.Name("editDiary"), object: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapDeleteBtn(_ sender: UIButton) {
        guard let uuidString = self.diary?.uuidString else { return }
        NotificationCenter.default.post(
            name: NSNotification.Name("deleteDiary"),
            object: uuidString,
            userInfo: nil
        )
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func starDiaryNotification(_ notification: NSNotification) {
        guard let starDiary = notification.object as? [String: Any] else { return }
        guard let isStar = starDiary["isStar"] as? Bool else { return }
        guard let uuidString = starDiary["uuidString"] as? String else { return }
        guard let diary = self.diary else { return }
        if diary.uuidString == uuidString {
            self.diary?.isStar = isStar
            self.configureView()
        }
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
        guard let diary = notification.object as? Diary else { return }
        guard let row = notification.userInfo?["indexPath.row"] as? Int else { return }
        self.diary = diary
        self.configureView()
    }
    
    @objc func tapStarButton() {
        guard let isStar = self.diary?.isStar else { return }
        if isStar {
            self.starBtn?.image = UIImage(systemName: "star")
        } else {
            self.starBtn?.image = UIImage(systemName: "star.fill")
        }
        self.diary?.isStar = !isStar
        NotificationCenter.default.post(
            name: NSNotification.Name("starDiary"),
            object: [
                "diary": self.diary,
                "isStar": self.diary?.isStar,
                "uuidString": diary?.uuidString
            ],
            userInfo: nil
        )
    }
    
    // 관찰이 필요없을 때 삭제한다. 
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
