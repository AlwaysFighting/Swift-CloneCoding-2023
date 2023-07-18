//
//  BookMarkViewController.swift
//  TranslateApp
//
//  Created by 목정아 on 2023/07/18.
//

import UIKit
import SnapKit

final class BookMarkListViewController : UIViewController {
    
    private var bookmark: [Bookmark] = []
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let inset : CGFloat = 16.0
        layout.estimatedItemSize = CGSize(width: view.frame.width - (inset * 2), height: 100.0)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = inset
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .secondarySystemBackground
        
        collectionView.register(BookmarkCollectionViewCell.self, forCellWithReuseIdentifier: BookmarkCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("Bookmark", comment: "즐겨찾기")
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bookmark = UserDefaults.standard.bookmarks
        collectionView.reloadData()
    }
    
}

private extension BookMarkListViewController {
    func setup() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension BookMarkListViewController : UICollectionViewDelegate {
    
}

extension BookMarkListViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookmark.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookmarkCollectionViewCell.identifier, for: indexPath) as? BookmarkCollectionViewCell else { return UICollectionViewCell() }
        
        let bookmark = bookmark[indexPath.item]
        cell.setup(from: bookmark)
        
        return cell
    }
}

