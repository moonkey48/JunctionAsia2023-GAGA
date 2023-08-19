//
//  UserLanguageSelectionView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Gucci on 2023/08/19.
//

import SwiftUI

struct UserLanguageSelectionView: View {
    private let title = "여러분의 언어를\n선택해주세요!"
    @Binding var selectedTabTag: Int
    
    private var isLanguageSelected: Bool {
        userLanguage != "Unselected"
    }
    @AppStorage("userLanguage") var userLanguage = "Unselected"
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.titleDefault)
                    .border(.background)
                Spacer()
            }
            .padding(.horizontal)
            
            ForEach(Country.allCases, id: \.self) { country in
                if country != .unknown {
                    LanguageCell(country: country)
                }
            }
            .padding(.horizontal)
            .padding(.top, 16)
            
            Spacer()
            
            Button {
                selectedTabTag = 1
            } label: {
                Text("다음")
                    .primaryButtonStyle(isSelected: isLanguageSelected)
            }
        }

    }
    
}

struct UserLanguageSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        UserLanguageSelectionView(selectedTabTag: .constant(1))
    }
}
