//
//  LaunchScreenView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Seungui Moon on 2023/08/20.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            Color(hex: "0B033F")
            Image("logoWhite")
                .resizable()
                .scaledToFit()
                .scaleEffect(0.5)
        }
        .ignoresSafeArea()
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
