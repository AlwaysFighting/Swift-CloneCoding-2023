//
//  BookReview.swift
//  BookReview
//
//  Created by 목정아 on 2023/07/30.
//

import Foundation

struct BookReview : Codable {
    let title: String
    let contents: String
    let imageURL: URL?
}
