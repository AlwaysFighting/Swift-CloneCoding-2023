//
//  EventSectionView.swift
//  Starbucks
//
//  Created by 목정아 on 2023/07/17.
//

import SwiftUI

struct EventSectionView: View {
    
    @Binding var events: [Event]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16.0) {
                ForEach(events) { event in
                    EventSectionItemView(event: event)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 220, maxHeight: .infinity)
            .padding(.horizontal, 16.0)
        }
    }
}

struct EventSectionItemView: View {
    let event: Event
    
    var body: some View {
        VStack {
            HStack {
                Text("Events")
                    .font(.headline)
                Spacer()
                Button(action: {
                    print("See All")
                }, label: {
                    Text("See all")
                        .font(.subheadline)
                })
            }.frame(maxWidth: .infinity, alignment: .leading)
            event.image
                .resizable()
                .scaledToFill()
                .frame(height: 150)
                .clipped()
            Text(event.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            Text(event.description)
                .lineLimit(1)
                .font(.callout)
                .frame(maxWidth: .infinity, alignment: .topLeading)
        }.frame(width: UIScreen.main.bounds.width - 32.0)
    }
    
}
