//
//  TTSTest.swift
//  JunctionAsia2023-GAGA
//
//  Created by 이주원 on 2023/08/19.
//

import SwiftUI
import AVFoundation

struct TTSTest: View {
    let synthesizer = AVSpeechSynthesizer()
    @State private var textToRead: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter Text", text: $textToRead)
                .padding()
            
            Button("Read Text") {
                // 현재 음성 출력 중인 내용 중단
                synthesizer.stopSpeaking(at: .immediate)
                
                // 음성 출력할 내용을 포함한 AVSpeechUtterance 생성
                let utterance = AVSpeechUtterance(string: textToRead)
                
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
                print("Read Text: \(textToRead)")
            }
            .padding()
        }
    }
}

struct TTSTest_Previews: PreviewProvider {
    static var previews: some View {
        TTSTest()
    }
}
