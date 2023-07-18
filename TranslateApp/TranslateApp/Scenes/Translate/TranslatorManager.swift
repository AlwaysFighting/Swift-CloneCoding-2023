//
//  TranslatorManager.swift
//  TranslateApp
//
//  Created by 목정아 on 2023/07/19.
//

import Alamofire
import Foundation

struct TranslatorManager {
    var sourceLanguage : Language = .ko
    var targetLanguage: Language = .en
    
    func tranlate(
        from text: String,
        completionHandler : @escaping(String) -> Void
    ) {
        guard let url = URL(string: "https://openapi.naver.com/v1/papago/n2mt") else { return print("URL ERROR") }
        
        let requestModel = TranslateRequestModel(
            source: sourceLanguage.languageCode,
            target: targetLanguage.languageCode,
            text: text
        )
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "CLIENT_ID",
            "X-Naver-Client-Secret": "CLIENT_SECRET_KEY"
        ]
        
        AF
            .request(url, method: .post, parameters: requestModel, headers: headers)
            .responseDecodable(of: TranslateReponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.translatedText)
                case .failure(let error):
                    print(response.error as Any)
                }
            }
            .resume()
    }
}
