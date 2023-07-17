//
//  SettingView.swift
//  Starbucks
//
//  Created by 목정아 on 2023/07/17.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        List {
            Section {
                SettingUserInfoSectionView()
            }
            Button("회원 정보 수정") {
            
            }
            .accentColor(.black)
            Button("회원 탈퇴") {
                
            }
            .accentColor(.black)
        }
        .navigationTitle("설정")
        .listStyle(GroupedListStyle())
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingUserInfoSectionView : View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4.0) {
                Text(User.shard.userName)
                    .font(.title)
                Text(User.shard.account)
                    .font(.caption)
            }
            Spacer()
            Button(action: {}) {
                Text("로그아웃")
                    .accentColor(.green)
                    .font(.system(size: 14.0, weight: .bold, design: .default))
            }
            .padding(8.0)
            .overlay(Capsule().stroke(Color.green))
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
