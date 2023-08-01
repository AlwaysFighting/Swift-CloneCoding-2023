//
//  ReviewListPresenterTests.swift
//  BookReviewTests
//
//  Created by 목정아 on 2023/07/28.
//

import XCTest
@testable import BookReview

class ReviewListPresenterTests: XCTestCase {
    // 테스트 대상 설정하기
    var sut : ReviewListPresenter!
    var viewController: MockReviewListViewController!
    var userDefaultsManager : MockUserDefaultsManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockReviewListViewController()
        userDefaultsManager = MockUserDefaultsManager()
        
        sut = ReviewListPresenter(
            viewController: viewController,
            userDefaultsManager: userDefaultsManager
        )
    }
    
    // 테스트가 끝날 때마다 부르는 메서드
    override func tearDown() {
        sut = nil
        viewController = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad가_호출될_떄() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupViews)
    }
    
    func text_viewWillAppear가_호출될_때() {
        sut.viewWillAppear()
        
        XCTAssertTrue(userDefaultsManager.isCalledGetReviews)
        XCTAssertTrue(viewController.isCalledReloadTableView)
    }
    
    func test_didTapRightBarButtonItem이_호출될_때() {
        sut.didTapRightBarButtonItem()
        
        XCTAssertTrue(viewController.isCalledPresentToReviewWriteViewController)
    }
    
}


