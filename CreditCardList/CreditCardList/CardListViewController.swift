import UIKit
import Kingfisher
import FirebaseDatabase

class CardListViewController: UITableViewController {
    
    var ref: DatabaseReference!
    
    var creditCardList = [CreditCard]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerNib()
        self.realtimeDatabase()
    }
    
    private func registerNib() {
        let nib = UINib(nibName: CardListCell.identifier, bundle: nil) //⭐️
                tableView.register(nib, forCellReuseIdentifier: CardListCell.identifier) //⭐️
        
//        let nibName = UINib(nibName: "CardListCell", bundle: nil)
//        self.tableView.register(nibName, forCellReuseIdentifier: "CardListCell")
    }
    
    private func realtimeDatabase() {
        self.ref = Database.database().reference()
        
        self.ref.observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: [String: Any]] else { return }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let cardData = try JSONDecoder().decode([String:CreditCard].self, from: jsonData)
                let cardList = Array(cardData.values)
                self.creditCardList = cardList.sorted { $0.rank < $1.rank }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print("ERROR JSON PARSING : \(error)")
            }
        }
    }
}

extension CardListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return creditCardList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListCell", for: indexPath) as? CardListCell else { return UITableViewCell() }
        cell.rankLabel.text = "\(creditCardList[indexPath.row].rank)위"
        cell.promotionLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
        cell.cardNameLabel.text = "\(creditCardList[indexPath.row].name)"
        
        let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        cell.cardImageView.kf.setImage(with: imageURL)
        
        return cell
      }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 상세 화면 전달
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailVC = storyboard.instantiateViewController(identifier: "CardDetailViewController") as? CardDetailViewController else { return }
        detailVC.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
