//
//  UserTypeSelectionView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Gucci on 2023/08/20.
//

import SwiftUI

struct UserTypeSelectionView: View {
    private let title = "사용자 유형을\n선택해주세요!"
    
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
                UserTypeCell(userType: userType)
            }
            .padding(.horizontal)
        }

    }
}

struct UserTypeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        UserTypeSelectionView()
    }
}
