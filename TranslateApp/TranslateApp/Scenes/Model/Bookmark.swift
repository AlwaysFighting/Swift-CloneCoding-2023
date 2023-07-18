//
//  Bookmark.swift
//  TranslateApp
//
//  Created by 목정아 on 2023/07/18.
//

import Foundation

struct Bookmark: Codable {
    let sourceLanguage: Language
    let translatedLanguage: Language
    
    let sourceText : String
    let translatedText : String
}
