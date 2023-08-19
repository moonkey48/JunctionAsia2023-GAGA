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
            TextField("텍스트를 입력하세요", text: $textToRead)
                .padding()
            
            Button("텍스트 읽기") {
                // 현재 음성 출력 중인 내용 중단
                synthesizer.stopSpeaking(at: .immediate)
                
                // 음성 출력할 내용을 포함한 AVSpeechUtterance 생성
                let utterance = AVSpeechUtterance(string: textToRead)
                
                // 한국어 TTS를 위한 음성 및 언어 설정
                utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
                
                // 음성 출력 시작
                synthesizer.speak(utterance)
                
                // 콘솔에 메시지 출력하여 TTS가 동작 중임을 확인 (시뮬레이터용)
                print("읽을 텍스트: \(textToRead)")
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
