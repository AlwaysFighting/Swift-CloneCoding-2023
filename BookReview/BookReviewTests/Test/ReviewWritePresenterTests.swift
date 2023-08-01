//
//  ReviewWritePresenterTests.swift
//  BookReviewTests
//
//  Created by 목정아 on 2023/08/01.
//

import XCTest

@testable import BookReview

class ReviewWritePresenterTests : XCTestCase {
    
    var sut : ReviewWritePresenter!
    var viewController : MockReviewWriteViewController!
    var userDefaultManager: MockUserDefaultsManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockReviewWriteViewController()
        userDefaultManager = MockUserDefaultsManager()
        
        sut = ReviewWritePresenter(
            viewController: viewController,
            userDefaultsManager: userDefaultManager
        )
    }
    
    
    override func tearDown() {
        sut = nil
        
        viewController = nil
        userDefaultManager = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad가_호출될_때() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupViews)
    }
    
    func test_didTapLeftBarButton이_호출될_때() {
        sut.didTapLeftBarButton()
        
        XCTAssertTrue(viewController.isCalledShowCloseAlertController)
    }
    
    func test_didTapRightBarButton이_호출될_때_book이_존재하지않으면() {
        sut.book = nil
        sut.didTapRightBarButton(contentsText: "참 공부하기 좋은 책이에요.")
        
        XCTAssertFalse(userDefaultManager.isCalledSetReviews)
        XCTAssertFalse(viewController.isCalledClose)
    }
    
    func test_didTapRightBarButton이_호출될_때_book이_존재하고_contentsText가_존재하지않으면() {
        sut.book = Book(title: "Swift", imageURL: "")
        sut.didTapRightBarButton(contentsText: nil)
        
        XCTAssertFalse(userDefaultManager.isCalledSetReviews)
        XCTAssertFalse(viewController.isCalledClose)
    }
    
    func test_didTapRightBarButton이_호출될_때_book이_존재하고_contentsText가_placeholder와_같으면() {
        sut.book = Book(title: "Swift", imageURL: "")
        sut.didTapRightBarButton(contentsText: sut.contentsTextViewPlaceholderText)
        
        XCTAssertFalse(userDefaultManager.isCalledSetReviews)
        XCTAssertFalse(viewController.isCalledClose)
    }
    
    func test_didTapRightBarButton이_호출될_때_book이_존재하고_contentsText가_placeholder와_같지않게_존재하면_실행된다() {
        sut.book = Book(title: "Swift", imageURL: "")
        sut.didTapRightBarButton(contentsText: "참 공부하기 좋은 책이에요.")

        XCTAssertTrue(userDefaultManager.isCalledSetReviews)
        XCTAssertTrue(viewController.isCalledClose)
    }
    
    func test_didTapBookTitleButton이_호출될_때() {
        sut.didTapBookTitleButton()
        
        XCTAssertTrue(viewController.isCalledPresentToSearchBookViewController)
    }
}

final class MockReviewWriteViewController: ReviewWriteProtocol {
    
    var isCalledSetupNavigationBar = false
    var isCalledShowCloseAlertController = false
    var isCalledClose = false
    var isCalledSetupViews = false
    var isCalledPresentToSearchBookViewController = false
    var isCalledUpdateViews = false
    
    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }
    
    func showCloseAlertController() {
        isCalledShowCloseAlertController = true
    }
    
    func close() {
        isCalledClose = true
    }
    
    func setupLayout() {
        isCalledSetupViews = true
    }
    
    func presentToSearchBookViewController() {
        isCalledPresentToSearchBookViewController = true
    }
    
    func updateViews(title: String, imageURL: URL?) {
        isCalledUpdateViews = true
    }
    
    
}
