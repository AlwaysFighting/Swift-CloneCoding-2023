//
//  HomeViewModel.swift
//  Starbucks
//
//  Created by 목정아 on 2023/07/17.
//

import SwiftUI

class HomeViewModel : ObservableObject {
    @Published var isNeedToReload  = false {
        // didSet 같은 경우 isNeedToReload 가 변경되면 초기에 불러온 값 이후로 실행된다.
        didSet {
            guard isNeedToReload else { return }
            
            coffeeMenu.shuffle()
            events.shuffle()
            
            isNeedToReload = false
        }
    }
    
    @Published  var coffeeMenu : [CoffeMenu] = [
        CoffeMenu(image: Image("coffee"), name: "아메리카노"),
        CoffeMenu(image: Image("coffee"), name: "아이스 아메리카노"),
        CoffeMenu(image: Image("coffee"), name: "카페라떼"),
        CoffeMenu(image: Image("coffee"), name: "아이스 카페라떼"),
        CoffeMenu(image: Image("coffee"), name: "드립커피"),
        CoffeMenu(image: Image("coffee"), name: "아이스 드립커피"),
    ]
    
    @Published  var events: [Event] = [
        Event(image: Image("coffee"), title: "제주도 한정 메뉴", description: "제주도 한정 음료가 출시되었습니다! 꼭 드셔보세요"),
        Event(image: Image("coffee"), title: "여름 한정 메뉴", description: "여름에는 시원한 아이스 아메리카노!")
    ]
}

