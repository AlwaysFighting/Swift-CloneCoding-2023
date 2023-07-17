//
//  Event.swift
//  Starbucks
//
//  Created by 목정아 on 2023/07/17.
//

import SwiftUI

struct Event : Identifiable {
    let id = UUID()
    
    let image: Image
    let title: String
    let description: String
}
