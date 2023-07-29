//
//  BookSearchRequestModel.swift
//  BookReview
//
//  Created by 목정아 on 2023/07/29.
//

import Foundation

struct BookSearchRequestModel : Codable {
    /// 검색할 책 키워드
    let query : String
}
