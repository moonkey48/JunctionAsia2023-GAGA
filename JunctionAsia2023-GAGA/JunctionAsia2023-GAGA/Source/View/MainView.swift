//
//  MainView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Lee Juwon on 2023/08/20.
//

import SwiftUI

struct MainView: View {
    @StateObject private var mcSession = TextMultipeerSession.shared
    @State private var showTTSModal = false
    @State private var showSTTModal = false
    @State private var isTextReceived = true
    
    var body: some View {
        VStack {
            HStack {
                Image("logoBlack")
                Spacer()
                NavigationLink {
                        SettingView()
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 24))
                            .foregroundColor(Color(hex: "646F7C"))
                    }
            }
            .padding()
            
            VStack(spacing: 16)  {
                TTSComponentView
                    .onTapGesture {
                        showTTSModal = true
                    }
                STTComponentView
                    .onTapGesture {
                        showSTTModal = true
                    }
            }
            Spacer()
        }
        .sheet(isPresented: $isTextReceived, content: {
            ReceivedTextView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        })
        .sheet(isPresented: $showSTTModal) {
            STTView(showSTTModal: $showSTTModal)
        }
        .sheet(isPresented: $showTTSModal) {
            TTSView()
        }
    }
}

extension MainView {
    var TTSComponentView: some View {
        VStack {
            HStack{
                Text("📝 텍스트")
                    .foregroundColor(Color.white)
                    .font(.system(size: 32, weight: .bold))
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
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
        .padding(30)
        .frame(width: 358, height: 254)
        .background(Color(hex: "6E65F4"))
        .cornerRadius(16)
    }
    var STTComponentView: some View {
        VStack {
            HStack{
                Text("🎙️ 음성인식")
                    .foregroundColor(Color.white)
                    .font(.system(size: 32, weight: .bold))
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
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
        .padding(30)
        .frame(width: 358, height: 254)
        .background(Color(hex: "0B033F"))
        .cornerRadius(16)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
