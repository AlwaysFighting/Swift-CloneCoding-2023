//
//  TranslateRequestModel.swift
//  TranslateApp
//
//  Created by 목정아 on 2023/07/19.
//

import Foundation

struct TranslateRequestModel: Codable {
    let source: String
    let target: String
    let text: String
}
