//
//  SearchBookPresent.swift
//  BookReview
//
//  Created by 목정아 on 2023/07/29.
//

import UIKit

protocol SearchBookProtocol {
    func setupLayout()
    func dismiss()
    func reloadVew()
}

protocol SearchBookDelegate {
    func selectBook(_ book : Book)
}

final class SearchBookPresent : NSObject {
    
    private let viewController : SearchBookProtocol
    private let bookSearchManager = BookSearchManager()
    
    private let delegate: SearchBookDelegate
    
    private var books : [Book] = []
    
    init(
        viewController : SearchBookProtocol,
        delegate : SearchBookDelegate
    ) {
        self.viewController = viewController
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        viewController.setupLayout()
    }
    
}

extension SearchBookPresent : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        bookSearchManager.request(from: searchText) { [weak self] newBooks in
            self?.books = newBooks
            self?.viewController.reloadVew()
        }
    }
}

extension SearchBookPresent : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = books[indexPath.row]
        delegate.selectBook(selectedBook)
        viewController.dismiss()
    }
}

extension SearchBookPresent : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = books[indexPath.row].title
        
        return cell
    }
    
}

