//
//  STTView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Seungui Moon on 2023/08/19.
//

import SwiftUI

struct STTView: View {
    @ObservedObject private var speachData = SpeachData.shared
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    @State private var smallCircleSize: CGFloat = 0.8
    @State private var bigCircleSize: CGFloat = 1.2
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                HStack{
                    Spacer()
                }
            }
            .ignoresSafeArea()
            .background(Color(hex: "#0B033F"))
            
            sttAnimationCircleView
            VStack {
                Spacer()
                    .frame(height: 100)
                HStack {
                    Text(speachData.speachText.isEmpty ? "말씀하시면 텍스트가 입력됩니다. " : speachData.speachText)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 24))
                    Spacer()
                }
                .padding()
                Spacer()
                Button {
                    // stop
                } label: {
                    stopButton
                }
            }
            
        }
        .onAppear {
            speechRecognizer.startTranscribing()
            circleAnimationStart()
        }
    }
    func circleAnimationStart(){
        withAnimation(.easeInOut(duration: 1.5).repeatForever()) {
            smallCircleSize = 0.6
        }
        withAnimation(.easeInOut(duration: 1.5).repeatForever()) {
            bigCircleSize = 0.8
        }
    }
}
extension STTView {
    var stopButton: some View {
        ZStack {
            Image("sttStopButton")
                .resizable()
                .frame(width: 156, height: 156)
            Image(systemName: "stop.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 58, height: 58)
        }
    }
    var sttAnimationCircleView: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .scaleEffect(bigCircleSize)
                    .foregroundColor(Color(hex: "#A9A3FB"))
                Circle()
                    .scaleEffect(smallCircleSize)
                    .foregroundColor(Color(hex: "#6E65F4"))
            }
            .scaleEffect(1.5)
            .offset(x:0,y:200)
        }
    }
}

struct STTView_Previews: PreviewProvider {
    static var previews: some View {
        STTView()
    }
}
