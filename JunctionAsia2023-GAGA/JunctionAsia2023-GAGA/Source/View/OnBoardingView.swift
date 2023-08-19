//
//  OnBoardingView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Gucci on 2023/08/20.
//

import SwiftUI

struct OnBoardingView: View {
    @State private var selectedTabTag = 0
    @Environment(\.dismiss) var dismiss
    private let tabViewWidth = UIScreen.width/2 - 20
    
    var body: some View {
        TabView(selection: $selectedTabTag) {
            UserLanguageSelectionView(selectedTabTag: $selectedTabTag)
                .tag(0)
            
            UserTypeSelectionView(selectedTabTag: $selectedTabTag)
                .tag(1)
        }
        .padding(.top, 20)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(
            /// custom tabview style
            HStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: tabViewWidth, height: 4)
                    .foregroundColor(selectedTabTag == 0 ? .custom(.primary) : .custom(.gray200))
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: tabViewWidth, height: 4)
                    .foregroundColor(selectedTabTag == 1 ? .custom(.primary) : .custom(.gray200))
            }
                .padding(.top, 5)
            , alignment: .top
        )
        // 유저 타입 설정되면 OnBoardingView 끝
        .onChange(of: selectedTabTag) { tag in
            if (tag != 0) && (tag != 1)  {
                dismiss()
            }
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
