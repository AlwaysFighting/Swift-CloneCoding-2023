import UIKit
import Lottie

class CardDetailViewController: UIViewController {
    
    var promotionDetail: PromotionDetail?

    @IBOutlet weak var lottieView: LottieAnimationView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var benefitConditionLabel: UILabel!
    @IBOutlet weak var benefitDetailLabel: UILabel!
    @IBOutlet weak var benefitDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lottieAnimation()
    }
    
    private func lottieAnimation() {
        let animationView = LottieAnimationView(name: "money")
        lottieView.contentMode = .scaleAspectFit
        lottieView.addSubview(animationView)
        animationView.frame = lottieView.bounds
        animationView.loopMode = .loop
        animationView.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let detail = promotionDetail
        
        self.titleLabel.text = """
    \(detail?.companyName ?? "")카드 쓰면
    \(detail?.amount ?? 0)만원 드려요
    """
        
        self.periodLabel.text = detail?.period ?? ""
        self.conditionLabel.text = detail?.condition ?? ""
        self.conditionLabel.text = detail?.benefitCondition ?? ""
        self.benefitDateLabel.text = detail?.benefitDate ?? ""
    }

}
