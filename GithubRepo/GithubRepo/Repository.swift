//
//  Repository.swift
//  GithubRepo
//
//  Created by 목정아 on 2023/07/13.
//

import Foundation

struct Repository : Decodable {
    let id: Int
    let name: String
    let description: String
    let staragazersCount: Int
    let language: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, language
        case staragazersCount = "stargazers_count"
    }
}
