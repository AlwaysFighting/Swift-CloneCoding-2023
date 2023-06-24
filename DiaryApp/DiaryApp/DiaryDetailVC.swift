import UIKit

protocol DiaryDetailViewDelegate: AnyObject {
    func didSelectDelete(indexPath: IndexPath)
    func didSelectStar(indexPath : IndexPath, isStar: Bool)
}

class DiaryDetailVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var starBtn: UIBarButtonItem?
    
    weak var delegate: DiaryDetailViewDelegate?
    
    var diary: Diary?
    var indexpath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
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
        guard let indexpath = self.indexpath else { return }
        self.delegate?.didSelectDelete(indexPath: indexpath)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
        guard let diary = notification.object as? Diary else { return }
        guard let row = notification.userInfo?["indexPath.row"] as? Int else { return }
        self.diary = diary
        self.configureView()
    }
    
    @objc func tapStarButton() {
        guard let isStar = self.diary?.isStar else { return }
        guard let indexpath = self.indexpath else { return }
        if isStar {
            self.starBtn?.image = UIImage(systemName: "star")
        } else {
            self.starBtn?.image = UIImage(systemName: "star.fill")
        }
        self.diary?.isStar = !isStar
        self.delegate?.didSelectStar(indexPath: indexpath, isStar: self.diary?.isStar ?? false)
    }
    
    // 관찰이 필요없을 때 삭제한다. 
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
