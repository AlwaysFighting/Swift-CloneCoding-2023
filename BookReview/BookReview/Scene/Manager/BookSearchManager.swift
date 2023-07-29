//
//  BookSearchManager.swift
//  BookReview
//
//  Created by 목정아 on 2023/07/29.
//

import Foundation
import Alamofire

struct BookSearchManager {
    
    func request(from keyword : String, completionHandeler: @escaping (([Book]) -> Void )) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/book.json") else { return }
        
        let parameters = BookSearchRequestModel(query: keyword)
        
        let headers : HTTPHeaders = [
            "X-Naver-Client-Id" : "NAVER_CLIENT_ID",
            "X-Naver-Client-Secret" : "NAVER_CLIENT_SECRET"
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: BookSearchReponseModel.self) { resonse in
                switch resonse.result {
                case .success(let result) :
                    completionHandeler(result.items)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }.resume()
    }
    
}
