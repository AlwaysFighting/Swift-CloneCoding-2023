import UIKit

class NoticeViewController: UIViewController {
    
    // Tuple 생성
    var noticeContents: (title: String, detail: String, date: String)?

    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UI()
        
    }
    
    private func UI() {
        self.noticeView.layer.cornerRadius = 6
        view.backgroundColor = .black.withAlphaComponent(0.5)
        
        guard let noticeContents = noticeContents else { return }
        self.titleLabel.text = noticeContents.title
        self.detailLabel.text = noticeContents.detail
        self.dateLabel.text = noticeContents.date
    }

    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    
}
