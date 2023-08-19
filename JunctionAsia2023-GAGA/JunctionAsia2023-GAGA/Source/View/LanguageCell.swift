//
//  LanguageCell.swift
//  JunctionAsia2023-GAGA
//
//  Created by Gucci on 2023/08/19.
//

import SwiftUI

struct LanguageCell: View {
    let country: Country
    private var isSelected: Bool {
        return userLanguage == country.language
    }
    @AppStorage("userLanguage") var userLanguage: String = "Anonymous"
    
    var body: some View {
        HStack {
            Image(country.flag)
                .resizable()
                .frame(width: 60, height: 36)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(Color.custom(.gray200), lineWidth: 2)
                }
                .padding(.leading, 24)
            
            Text(country.language)
                .font(.bodySemibold)
                .foregroundColor(!isSelected ? Color.custom(.gray600) : Color.custom(.white))
                .padding(.leading, 16)
            
            Spacer()
            
            Circle()
                .frame(width: 28, height: 28)
                .foregroundColor(.white)
                .overlay {
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .opacity(isSelected ? 1.0 : 0.0)
                }
                .padding(.trailing, 24)
            
        }
        .frame(height: 84)
        .background(!isSelected ? Color.custom(.gray200) : Color.custom(.secondary))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .onTapGesture {
            userLanguage = country.language
        }
    }
}

struct LanguageCell_Previews: PreviewProvider {
    static var previews: some View {
        LanguageCell(country: Country.uk)
    }
}
