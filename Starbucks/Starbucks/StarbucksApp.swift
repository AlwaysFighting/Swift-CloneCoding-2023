//
//  StarbucksApp.swift
//  Starbucks
//
//  Created by 목정아 on 2023/07/17.
//

import SwiftUI

@main
struct StarbucksApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .accentColor(.green)
        }
    }
}

// tintColor = accentColor
