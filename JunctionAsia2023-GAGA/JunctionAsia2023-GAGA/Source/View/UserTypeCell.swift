//
//  UserTypeCell.swift
//  JunctionAsia2023-GAGA
//
//  Created by Gucci on 2023/08/20.
//

import SwiftUI

struct UserTypeCell: View {
    let userType: UserType
    private var isSelected: Bool {
        return userType.text == selectedUserType
    }
    @AppStorage("userType") var selectedUserType = "Unselected"
    
    var body: some View {
        HStack {
            Text(userType.imageString)
                .background(Color.custom(.white))
                .font(.titleDefault)
                .frame(width: 60, height: 36)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(Color.custom(.gray200), lineWidth: 2)
                }
//                .padding(.leading, 24)
            
            Text(userType.text)
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
            selectedUserType = userType.text
        }
    }
}

struct UserTypeCell_Previews: PreviewProvider {
    static var previews: some View {
        UserTypeCell(userType: .driver)
    }
}
