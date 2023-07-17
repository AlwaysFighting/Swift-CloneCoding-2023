//
//  Tab.swift
//  Starbucks
//
//  Created by 목정아 on 2023/07/17.
//

import Foundation
import SwiftUI

enum Tab {
    case home
    case other
    
    // associate value
    var tabTextItem: Text {
        switch self {
            case .home: return Text("Home")
            case .other: return Text("Other")
        }
    }
    
    var imageItem: Image {
        switch self {
            case .home : return Image(systemName: "house.fill")
            case .other : return Image(systemName: "ellipsis")
        }
    }
}
