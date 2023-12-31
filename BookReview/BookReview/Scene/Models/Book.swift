//
//  Book.swift
//  BookReview
//
//  Created by 목정아 on 2023/07/29.
//

import Foundation

struct Book: Decodable {
    let title : String
    private let image : String?
    
    var imageURL : URL? { URL(string: image ?? "")}
    
    init(title: String, imageURL: String?) {
        self.title = title
        self.image = imageURL
    }
}
