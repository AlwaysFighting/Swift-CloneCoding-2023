//
//  ReviewWritePresenter.swift
//  BookReview
//
//  Created by 목정아 on 2023/07/28.
//

import UIKit

protocol ReviewWriteProtocol {
    func setupNavigationBar()
    func showCloseAlertController()
    func close()
    func  setupLayout()
    func presentToSearchBookViewController()
    func updateViews(title: String, imageURL: URL?)
}

final class ReviewWritePresenter {
    
    private let viewController : ReviewWriteProtocol
    private var userDefaultsManager : UserDefaultsManagerProtocol
    
    var book: Book?
    
    let contentsTextViewPlaceholderText = "내용을 입력해주세요."
    
    init(
        viewController: ReviewWriteProtocol,
    userDefaultsManager : UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupLayout()
    }
    
    func didTapLeftBarButton() {
        viewController.showCloseAlertController()
    }
    
    func didTapRightBarButton(contentsText: String?) {
        
        guard
            let book = book,
            let contentsText = contentsText,
                contentsText != contentsTextViewPlaceholderText
        else { return }
        
        let bookReview = BookReview(
            title: book.title,
            contents: contentsText,
            imageURL: book.imageURL
        )
        
        userDefaultsManager.setReview(bookReview)
        
        viewController.close()
    }
    
    func didTapBookTitleButton() {
        viewController.presentToSearchBookViewController()
    }
    
}

extension ReviewWritePresenter: SearchBookDelegate {
    
    func selectBook(_ book: Book) {
        self.book = book
        
        viewController.updateViews(title: book.title, imageURL: book.imageURL)
    }
    
    
}
