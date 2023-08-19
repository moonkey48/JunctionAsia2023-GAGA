//
//  UserLanguageSelectionView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Gucci on 2023/08/19.
//

import SwiftUI

struct UserLanguageSelectionView: View {
    
    private let title = "여러분의 언어를\n선택해주세요!"
    
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
                LanguageCell(country: country)
            }
            .padding(.horizontal)
        }

    }
    
}

struct UserLanguageSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        UserLanguageSelectionView()
    }
}
