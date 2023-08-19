//
//  JunctionAsia2023_GAGAApp.swift
//  JunctionAsia2023-GAGA
//
//  Created by Seungui Moon on 2023/08/18.
//

import SwiftUI

@main
struct JunctionAsia2023_GAGAApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
            OnBoardingView()
        }
    }
}
