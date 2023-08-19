//
//  SettingView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Gucci on 2023/08/20.
//

import SwiftUI

struct SettingView: View {
    private var selectedLanguage: String {
        if let stored = UserDefaults.standard.string(forKey: "userLanguage") {
            return stored
        }
        return ""
    }
    
    private var selectedUserType: String {
        if let stored = UserDefaults.standard.string(forKey: "userType") {
            return stored
        }
        return ""
    }
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                NavigationLink {
                    EmptyView()
                } label: {
                    capsuleView("User Type", selectedUserType)
                }
                .padding(.top, 32)

                NavigationLink {
                    EmptyView()
                } label: {
                    capsuleView("Language", selectedLanguage)
                }
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("Settings")
        }
    }
    
    func capsuleView(_ title: String, _ category: String) -> some View {
        HStack {
            Text(title)
                .font(.bodySemibold)
                .foregroundColor(.custom(.gray600))
                .padding(.leading, 16)
            
            Spacer()
            Text(selectedLanguage)
                .font(.bodyRegular)
                .foregroundColor(.custom(.gray400))
            
            Image(systemName: "chevron.right")
                .foregroundColor(.custom(.gray400))
                .padding(.horizontal, 16)
        }
        .frame(height: 84)
        .background( Color.custom(.gray100))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.custom(.gray200), lineWidth: 2)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
