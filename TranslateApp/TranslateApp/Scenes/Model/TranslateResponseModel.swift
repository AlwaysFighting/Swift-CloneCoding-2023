//
//  TranslateResponseModel.swift
//  TranslateApp
//
//  Created by 목정아 on 2023/07/19.
//

import Foundation

struct TranslateReponseModel: Decodable {
    
    private let message: Message

    var translatedText: String { message.result.translatedText }

    struct Message: Decodable {
        let result: Result
    }

    struct Result: Decodable {
        let translatedText: String
    }
}
