//
//  MenuSuggestionSectionView.swift
//  Starbucks
//
//  Created by 목정아 on 2023/07/17.
//

import SwiftUI

struct MenuSuggestionSectionView: View {
    
    @Binding var coffeeMenu : [CoffeMenu]
    
    var body: some View {
        VStack {
            Text("\(User.shard.userName)을 위한 추천 메뉴")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16.0)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(coffeeMenu) { menu in
                        MenuSuggestionItemView(coffeeMenu: menu)
                    }
                }
                .padding(.horizontal, 16.0)
            }
        }
    }
}

struct MenuSuggestionItemView: View {
    let coffeeMenu: CoffeMenu
    
    var body: some View {
        VStack {
            coffeeMenu.image
                .resizable()
                .clipShape(Circle())
                .frame(width: 100, height: 100)
                .padding(5)
            Text(coffeeMenu.name)
                .font(.caption)
        }
    }
}
