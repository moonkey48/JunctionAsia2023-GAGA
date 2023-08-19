//
//  TTSView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Lee Juwon on 2023/08/19.
//

import SwiftUI
import AVFoundation

struct TTSView: View {
    @Binding var showTTSModal: Bool
    @State private var text: String = ""
    let synthesizer = AVSpeechSynthesizer() // AVSpeechSynthesizer 추가
    @ObservedObject private var papagoModel = LanguageModel.shared
    @StateObject private var textSession = TextMultipeerSession.shared

    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(hex: "#E9EBEE"), lineWidth: 2)
                    .frame(width: 358, height: 360)
                
                TextEditor(text: $text)
                    .foregroundColor(Color(.black))
                    .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color(hex: "#F7F8F9")))
                    .frame(width: 330, height: 330)
                    .overlay(
                        VStack {
                            if text.isEmpty {
                                Text("Communicate with the driver through text.\n ex) 'Please go to this address.'")
                                    .foregroundColor(Color(hex: "#C5C8CE"))
                                    .multilineTextAlignment(.leading)
                                    .font(.bodySemibold)
                        .padding(.top, -153)
                        .padding(.leading, -24)
                            }
                        }
                    )
            }
            .padding(.top, 115)

            Spacer()
            
            Button(action: {
                translate(value: text)
//                handleTTS()
            }) {
                Text("Send")
                    .foregroundColor(.white)
                    .frame(width: 368, height: 56)
                    .background(text.isEmpty ? Color(hex: "#A9A3FB") : Color(hex: "#6E65F4"))
                    .cornerRadius(12)
                    .font(.bodySemibold)
            }
            .disabled(text.isEmpty)
            .padding(.bottom, 27)
        }
        .onChange(of: papagoModel.translatedText) { translatedText in
            textSession.send(text: translatedText)
            showTTSModal = false
        }
    }
    private func translate(value: String){
        Task {
            do {
                try await papagoModel.fetchTranslation(with: value)
                print(papagoModel.translatedText)
            } catch {
                print("error on papago")
            }
        }
    }
    
    private func handleTTS(){
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



//struct TTSView_Previews: PreviewProvider {
//    static var previews: some View {
//        TTSView()
//    }
//}
