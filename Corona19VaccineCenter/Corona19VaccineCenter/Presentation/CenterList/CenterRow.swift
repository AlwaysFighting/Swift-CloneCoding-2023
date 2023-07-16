//
//  CenterRow.swift
//  Corona19VaccineCenter
//
//  Created by 목정아 on 2023/07/16.
//

import SwiftUI

struct CenterRow: View {
    var center: Center
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(center.facilityName)
                    .font(.headline)
                Text(center.centerType.rawValue)
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
            Text(center.address)
                .font(.footnote)
            
            if let url = URL(string: "tel:" + center.phoneNumber) {
                // Link : 전화를 걸 수 있도록 (하이퍼링크처럼 표현 가능)
                // 자동적으로 IOS 단에서 기능을 제공한다. (글자 클릭 시 전화 이동)
                Link(center.phoneNumber, destination: url)
            }
        }
        .padding()
    }
}

struct CenterRow_Previews: PreviewProvider {
    static var previews: some View {
        let center0 = Center(id: 0, sido: .경기도, facilityName: "실내빙상장 앞", address: "경기도 뫄뫄시 뫄뫄구", lat: "37.404476", lng: "126.9491998", centerType: .central, phoneNumber: "010-0000-0000")
        CenterRow(center: center0)
    }
}
