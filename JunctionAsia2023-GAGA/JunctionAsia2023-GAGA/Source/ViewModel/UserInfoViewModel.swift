//
//  UserInfoViewModel.swift
//  JunctionAsia2023-GAGA
//
//  Created by Seungui Moon on 2023/08/20.
//

import Foundation

final class UserInfoViewModel: ObservableObject {
    static let shared = UserInfoViewModel()
    private init(){}
    
    @Published var userLanguage = ""
}
