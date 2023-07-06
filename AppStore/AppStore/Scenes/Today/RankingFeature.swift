//
//  RankingFeature.swift
//  AppStore
//
//  Created by 목정아 on 2023/07/06.
//

import Foundation

struct RankingFeature: Decodable {
    let title: String
    let description: String
    let isInPurchaseApp: Bool
}
