//
//  ReceivedTextView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Seungui Moon on 2023/08/20.
//

import AVFoundation
import SwiftUI

struct ReceivedTextView: View {
    @ObservedObject var mcSession = TextMultipeerSession.shared
    @Binding var receivedText: String
    let synthesizer = AVSpeechSynthesizer()
    var body: some View {
        VStack(alignment: .leading) {
            Text(receivedText)
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 30)
            Spacer()
            HStack() {
                retryButton
                answerButton
            }
        }
        .onAppear {
            handleTTS(text: receivedText)
        }
        .onChange(of: receivedText, perform: { newValue in
            handleTTS(text: newValue)
        })
        
        .padding()
    }
    private func handleTTS(text: String){
        // 현재 음성 출력 중인 내용 중단
        synthesizer.stopSpeaking(at: .immediate)
                        
        // 음성 출력할 내용을 포함한 AVSpeechUtterance 생성
        let utterance = AVSpeechUtterance(string: text)
                        
        // 사용자의 선호 언어 가져오기
        let preferredLanguage = Locale.preferredLanguages.first ?? "en"
                        
        // 선호 언어에 따라 TTS 음성 설정
        if preferredLanguage.contains("ko") {
            utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        } else {
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        }
                        
        // 음성 출력 시작
        synthesizer.speak(utterance)
                        
        // 콘솔에 메시지 출력하여 TTS가 동작 중임을 확인 (시뮬레이터용)
        print("Read Text: \(text)")
    }
}
extension ReceivedTextView {
    var retryButton: some View {
        VStack(alignment: .leading) {
            Text("다시 듣기")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
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
        .padding(25)
        .frame(width: 170, height: 170)
        .background(Color(hex: "0B033F"))
        .cornerRadius(16)
    }
    var answerButton: some View {
        VStack(alignment: .leading) {
            Text("답장하기")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
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
        .padding(25)
        .frame(width: 170, height: 170)
        .background(Color(hex: "6E65F4"))
        .cornerRadius(16)
    }
}

//struct ReceivedTextView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReceivedTextView()
//    }
//}
