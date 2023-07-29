//
//  UserDefaultsManager.swift
//  BookReview
//
//  Created by 목정아 on 2023/07/30.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    func getReview() -> [BookReview]
    func setReview(_ newValue : BookReview)
}

struct UserDefaultsManager : UserDefaultsManagerProtocol {
    
    enum Key: String {
        case review
    }
    
    func getReview() -> [BookReview] {
        guard let data = UserDefaults.standard.data(forKey: Key.review.rawValue) else { return [] }
        return (try? PropertyListDecoder().decode([BookReview].self, from: data)) ?? []
    }
    
    func setReview(_ newValue: BookReview) {
        var currentReviews: [BookReview] = getReview()
        currentReviews.insert(newValue, at: 0)
        
        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(currentReviews), forKey: Key.review.rawValue)
    }
}
