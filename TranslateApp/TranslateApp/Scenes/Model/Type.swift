//
//  Type.swift
//  TranslateApp
//
//  Created by 목정아 on 2023/07/18.
//

import UIKit

enum `Type`{
    case source
    case target
    
    var color: UIColor {
        switch self {
        case .source:
            return .label
        case .target:
            return .mainTintColor
        }
    }
}
