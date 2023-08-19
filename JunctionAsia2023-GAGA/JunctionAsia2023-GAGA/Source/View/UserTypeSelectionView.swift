//
//  UserTypeSelectionView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Gucci on 2023/08/20.
//

import SwiftUI

struct UserTypeSelectionView: View {
    private let title = "Please select\na user type!"
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
            VStack(spacing: 16) {
                ForEach(UserType.allCases, id: \.self) { userType in
                    UserTypeCell(userType: userType)
                }
            }
            .padding(.horizontal)
            .padding(.top, 16)
            
            Spacer()
            
            Button {
                withAnimation {
                    selectedTabTag = 2 // MainView로 이동
                }
            } label: {
                Text("다음")
                    .primaryButtonStyle(isSelected: isTypeSelected)
            }
            .disabled(!isTypeSelected)
        }

    }
}

struct UserTypeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        UserTypeSelectionView(selectedTabTag: .constant(0))
    }
}
