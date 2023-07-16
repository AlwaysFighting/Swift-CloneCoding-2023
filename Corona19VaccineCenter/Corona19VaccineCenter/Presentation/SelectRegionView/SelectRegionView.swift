//
//  SelectRegionView.swift
//  Corona19VaccineCenter
//
//  Created by 목정아 on 2023/07/16.
//

import SwiftUI

struct SelectRegionView: View {
    // View 가 바라볼 ObservedObject 라고 명시 (RX 의 bind 와 유사)
    @ObservedObject var viewModel = SelectRegionViewModel()
    
    private var items: [GridItem] {
        Array(repeating: .init(.flexible(minimum: 80)), count: 2)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: items, spacing: 20) {
                    ForEach(Center.Sido.allCases, id: \.id) {
                        sido in
                        let centers = viewModel.centers[sido] ?? []
                        NavigationLink(destination: CenterList(centers: centers)) {
                            SelectRegionItem(region: sido, count: centers.count)
                        }
                    }
                }
                .padding()
                .navigationTitle("코로나19 예방접종 센터")
            }
        }
    }
}

struct SelectRegionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SelectRegionViewModel()
        SelectRegionView(viewModel: viewModel)
    }
}
