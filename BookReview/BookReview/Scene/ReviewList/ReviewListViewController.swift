//
//  ReviewListViewController.swift
//  BookReview
//
//  Created by 목정아 on 2023/07/28.
//

import UIKit
import SnapKit

class ReviewListViewController: UIViewController {
    
    private lazy var presenter = ReviewListPresenter(viewController: self)
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.dataSource = presenter
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
    
    
}

extension ReviewListViewController : ReviewListProtocol {
    
    func setupNavigationController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "도서 리뷰"
    }
    
    func setUpNavigationBar() {
        let shareButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapRightBarButtonItem))
        shareButton.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = shareButton
    }
     
     func presentToReviewWriteViewController() {
         let vc = UINavigationController(rootViewController: ReviewWriteViewController())
         vc.modalPresentationStyle = .fullScreen
         present(vc, animated: true)
     }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
}

// MARK: - @objc

extension ReviewListViewController {
    @objc func didTapRightBarButtonItem() {
        presenter.didTapRightBarButtonItem()
    }
}

// MARK: - Layout

extension ReviewListViewController {
    func setupLayout() {
        [
            tableView
        ].forEach { view.addSubview($0) }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
}

// MARK: - UITableViewDataSource


// MARK: - Navigation
