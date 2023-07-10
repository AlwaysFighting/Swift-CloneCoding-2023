//
//  ViewController.swift
//  Instagram
//
//  Created by 목정아 on 2023/07/08.
//

import UIKit

class FeedViewController: UIViewController {
    
    private lazy var tableView: UITableView  = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.dataSource = self
        
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedTableViewCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationController()
        self.setUpNavigationBar()
        self.setTableViewLayout()
    }
    
}

// MARK: - Navigation
private extension FeedViewController {
    func setupNavigationController() {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        imageView.contentMode = .scaleAspectFit
    
        let image = #imageLiteral(resourceName: "InstagramLogo")
        imageView.image = image
        
        navigationItem.titleView = imageView
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setUpNavigationBar() {
        let uploadButton = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = uploadButton
    }
}

// MARK: - Layout
private extension FeedViewController {
    func setTableViewLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
      }
}

extension FeedViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.setUP()
        
        return cell
    }
    
}
