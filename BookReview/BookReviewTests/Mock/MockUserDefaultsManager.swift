//
//  MockUserDefaultsManager.swift
//  BookReviewTests
//
//  Created by 목정아 on 2023/08/01.
//

import Foundation

@testable import BookReview

final class MockUserDefaultsManager: UserDefaultsManagerProtocol {
    
    var isCalledGetReviews = false
    var isCalledSetReviews = false
    
    func getReview() -> [BookReview] {
        isCalledGetReviews = true
        
        return []
    }
    
    func setReview(_ newValue: BookReview) {
        isCalledSetReviews = true
    }
}
