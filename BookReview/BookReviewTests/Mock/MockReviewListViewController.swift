//
//  MockReviewListViewController.swift
//  BookReviewTests
//
//  Created by 목정아 on 2023/08/01.
//

import Foundation

@testable import BookReview

final class MockReviewListViewController : ReviewListProtocol {
    
    var isCalledSetupNavigationBar = false
    var isCalledSetupViews = false
    var isCalledPresentToReviewWriteViewController = false
    var isCalledReloadTableView = false
    var isCalledTapRightBarButtonItem = false
    
    func setupNavigationController() {
        isCalledSetupNavigationBar = true
    }
    
    func setupLayout() {
        isCalledSetupViews = true
    }
    
    func setUpNavigationBar() {
        isCalledSetupNavigationBar = true
    }
    
    func didTapRightBarButtonItem() {
        isCalledTapRightBarButtonItem = true
    }
    
    func presentToReviewWriteViewController() {
        isCalledPresentToReviewWriteViewController = true
    }
    
    func reloadTableView() {
        isCalledReloadTableView = true
    }
    
    
}
