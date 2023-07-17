//
//  MainTabView.swift
//  Starbucks
//
//  Created by 목정아 on 2023/07/17.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Tab.home.imageItem
                    Tab.home.tabTextItem
                }
            OtherView()
                .tabItem {
                    Tab.other.imageItem
                    Tab.other.tabTextItem
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

// HStack
//struct SampleLazyHGrid: View {
//
//    struct Number: Identifiable {
//        let value : Int
//        var id: Int { value }
//    }
//
//    let numbers : [Number] = (0...100).map { Number(value: $0) }
//
//    var body: some View {
//        List {
//            Section(header: Text("Header")) {
//                ForEach(numbers) { number in
//                    Text("\(number.value)")
//                }
//            }
//            Section(header: Text("Second Footer"), footer: Text("Footer")) {
//                ForEach(numbers) { number in
//                    Text("\(number.value)")
//                }
//            }
//        }
//    }
//}
//
//struct SampleHStack_Previews: PreviewProvider {
//    static var previews: some View {
//        SampleLazyHGrid()
//    }
//}
