//
//  SearchBookViewController.swift
//  BookReview
//
//  Created by 목정아 on 2023/07/29.
//

import UIKit
import SnapKit

final class SearchBookViewController : UIViewController {
    
    private lazy var presenter = SearchBookPresent(
        viewController: self,
        delegate: searchBookDelegate
    )
    
    private let searchBookDelegate: SearchBookDelegate
    
    init(searchBookDelegate: SearchBookDelegate) {
        self.searchBookDelegate = searchBookDelegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        
        return tableView
    }()
    
    
}

extension SearchBookViewController : SearchBookProtocol {
    
    func setupLayout() {
        view.backgroundColor = .systemBackground
        
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = presenter
        navigationItem.searchController = searchController
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func dismiss() {
        navigationItem.searchController?.dismiss(animated: true)
        dismiss(animated: true)
    }
    
    func reloadVew() {
        tableView.reloadData()
    }
    
}
