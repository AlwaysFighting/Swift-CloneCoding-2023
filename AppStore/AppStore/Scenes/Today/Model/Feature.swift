//
//  Feature.swift
//  AppStore
//
//  Created by 목정아 on 2023/07/06.
//

import Foundation

struct Feature: Decodable {
    let type : String
    let appName: String
    let description: String
    let imageURL : String
}
