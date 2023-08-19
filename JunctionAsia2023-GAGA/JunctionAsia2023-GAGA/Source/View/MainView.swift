//
//  MainView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Lee Juwon on 2023/08/20.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            HStack {
                Image("logoBlack")
                Spacer()
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 24))
                    .foregroundColor(Color(hex: "646F7C"))

            }
            
            VStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 358, height: 254)
                        .foregroundColor(Color(hex: "6E65F4"))
                    Text("📝 Text")
                        .foregroundColor(Color.white)
                        .font(.system(.title))
                    ZStack {
                        Circle()
                            .frame(width: 56)
                            .foregroundColor(Color.white)
                            .opacity(0.24)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 24))
                            .foregroundColor(Color(.white))
                    }
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 358, height: 254)
                        .foregroundColor(Color(hex: "OB033F"))
                    Text("🎙️ Voice")
                        .foregroundColor(Color.white)
                        .font(.system(.title))
                    ZStack {
                        Circle()
                            .frame(width: 56)
                            .foregroundColor(Color.white)
                            .opacity(0.24)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 24))
                            .foregroundColor(Color(.white))
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
