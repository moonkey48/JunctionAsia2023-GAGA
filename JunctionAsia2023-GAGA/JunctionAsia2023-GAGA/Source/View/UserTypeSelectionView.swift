//
//  UserTypeSelectionView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Gucci on 2023/08/20.
//

import SwiftUI

struct UserTypeSelectionView: View {
    private let title = "사용자 유형을\n선택해주세요!"
    @Binding var selectedTabTag: Int
    
    private var isTypeSelected: Bool {
        userType != "Unselected"
    }
    @AppStorage("userType") var userType = "Unselected"
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.titleDefault)
                    .border(.background)
                Spacer()
            }
            .padding(.horizontal)
            
            ForEach(UserType.allCases, id: \.self) { userType in
                if userType != .unknown {
                    UserTypeCell(userType: userType)
                }
            }
            .padding(.horizontal)
            .padding(.top, 16)
            
            Spacer()
            
            Button {
                selectedTabTag = 2
            } label: {
                Text("다음")
                    .primaryButtonStyle(isSelected: isTypeSelected)
            }
        }

    }
}

struct UserTypeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        UserTypeSelectionView(selectedTabTag: .constant(0))
    }
}
