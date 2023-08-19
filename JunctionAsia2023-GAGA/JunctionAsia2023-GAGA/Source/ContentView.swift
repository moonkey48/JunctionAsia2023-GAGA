//
//  ContentView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Seungui Moon on 2023/08/18.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var showOnboarding = UserDefaults.standard.string(forKey: "userType") ?? "Unselected" == "Unselected"
    @State private var opacity: CGFloat = 1.0
    var body: some View {
        ZStack {
            if opacity == 0 {
                MainView()
                    .fullScreenCover(isPresented: $showOnboarding, content: OnBoardingView.init)
            }
            LaunchScreenView()
                .opacity(opacity)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8).delay(1)) {
                opacity = 0
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
