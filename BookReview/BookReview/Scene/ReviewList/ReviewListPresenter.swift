//
//  ReviewListPresenter.swift
//  BookReview
//
//  Created by 목정아 on 2023/07/28.
//

import UIKit
import Kingfisher

protocol ReviewListProtocol {
    func setupNavigationController()
    func setupLayout()
    func setUpNavigationBar()
    
    func didTapRightBarButtonItem()
    func presentToReviewWriteViewController()
    func reloadTableView()
}

final class ReviewListPresenter : NSObject {
    // VC 가 해야 할 프로토콜
    private let viewController : ReviewListProtocol
    private let userDefaultsManager = UserDefaultsManager()
    
    private var review : [BookReview] = []
    
    init(viewController: ReviewListProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupNavigationController()
        viewController.setUpNavigationBar()
        viewController.setupLayout()
    }
    
    func viewWillAppear() {
        review = userDefaultsManager.getReview()
        viewController.reloadTableView()
    }
    
    func didTapRightBarButtonItem() {
        viewController.presentToReviewWriteViewController()
    }
}

extension ReviewListPresenter : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return review.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let review = review[indexPath.row]
        
        cell.textLabel?.text = review.title
        cell.detailTextLabel?.text = review.contents
        cell.imageView?.kf.setImage(with: review.imageURL, placeholder: .none) { _ in
            cell.setNeedsLayout()
        }
        
        cell.selectionStyle = .none
        
        return cell
    }

}
