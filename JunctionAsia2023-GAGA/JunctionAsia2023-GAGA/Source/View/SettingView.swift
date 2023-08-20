//
//  SettingView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Gucci on 2023/08/20.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    
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
            VStack(spacing: 16) {
                NavigationLink {
                    UserTypeDetailView()
                } label: {
                    capsuleView("User Type", selectedUserType)
                }
                .padding(.top, 32)

                NavigationLink {
                    LanguageDetailView()
                } label: {
                    capsuleView("Language", selectedLanguage)
                }
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    func capsuleView(_ title: String, _ category: String) -> some View {
        HStack {
            Text(title)
                .font(.bodySemibold)
                .foregroundColor(.custom(.gray600))
                .padding(.leading, 16)
            
            Spacer()
            Text(category)
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

struct UserTypeDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(UserType.allCases, id: \.self) { userType in
                UserTypeCell(userType: userType)
            }
            
            Spacer()
            Button {
                dismiss()
            } label: {
                Text("Save")
                    .primaryButtonStyle(isSelected: true)
            }
        }
        .navigationTitle("User Type")
    }
}

struct LanguageDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                ForEach(Country.allCases, id: \.self) { country in
                    LanguageCell(country: country)
                }
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Text("Save")
                        .primaryButtonStyle(isSelected: true)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 16)
        .navigationTitle("Language")
    }
}
