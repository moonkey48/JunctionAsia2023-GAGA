//
//  JunctionAsia2023_GAGAApp.swift
//  JunctionAsia2023-GAGA
//
//  Created by Seungui Moon on 2023/08/18.
//

import SwiftUI

@main
struct JunctionAsia2023_GAGAApp: App {
    @State private var showOnboarding = UserDefaults.standard.string(forKey: "userType") ?? "Unselected" == "Unselected"
    var body: some Scene {
        WindowGroup {
            MainView()
                .fullScreenCover(isPresented: $showOnboarding, content: OnBoardingView.init)    
        }
    }
}
