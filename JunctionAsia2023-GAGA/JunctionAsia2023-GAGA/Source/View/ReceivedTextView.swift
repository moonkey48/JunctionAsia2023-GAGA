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
    @ObservedObject var papagoModel = LanguageModel.shared
    @ObservedObject var mainViewCommandViewModel = MainViewCommandViewModel.shared
    @Binding var receivedText: String
    @Binding var isTextReceived: Bool
    @Binding var showSTTModal: Bool
    var mainViewSTTRecognizer: MainViewSTTRecognizer
    let synthesizer = AVSpeechSynthesizer()
    @AppStorage("userType") var userType = "Unselected"
    var body: some View {
        VStack(alignment: .leading) {
            Text(receivedText)
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 30)
            Spacer()
            HStack() {
                retryButton
                    .onTapGesture {
//                        handleTTS(text: papagoModel.translatedText)
                        // 변경된 부분: 더 큰 음량으로 TTS 재생
                        handleTTS(text: papagoModel.translatedText)
                    }
                answerButton
                    .onTapGesture {
                        isTextReceived = false
                        showSTTModal = true
                    }
            }
        }
        .onChange(of: mainViewCommandViewModel.mainViewCommand, perform: { command in
            print(command.rawValue)
            switch command as MainViewCommands {
            case .sttCommand:
                isTextReceived = false
                showSTTModal = true
            case .ttsCommand:
                break
            case .closeCommand:
                isTextReceived = false
            case .restartCommand:
                break
            case .notDefined:
                break
            }
        })
        .onAppear {
            translate(value: receivedText)
            mainViewSTTRecognizer.startTranscribing()
        }
        .onChange(of: papagoModel.translatedText, perform: { newValue in
            handleTTS(text: newValue)
        })
        
        .padding()
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
    
    private func handleTTS(text: String){
        // 현재 음성 출력 중인 내용 중단
        synthesizer.stopSpeaking(at: .immediate)
                        
        // 음성 출력할 내용을 포함한 AVSpeechUtterance 생성
        let utterance = AVSpeechUtterance(string: text)
        utterance.volume = 100.0
                        
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
            
            if userType == "Driver" {
                Text("다시 듣기")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
            } else {
                Text("Listen Again")
                    .foregroundColor(Color.white)
                    .font(.system(size: 32, weight: .bold))
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
        .padding(25)
        .frame(width: 170, height: 170)
        .background(Color(hex: "0B033F"))
        .cornerRadius(16)
    }
    var answerButton: some View {
        VStack(alignment: .leading) {
            
            if userType == "Driver" {
                Text("답장하기")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
            } else {
                Text("Reply")
                    .foregroundColor(Color.white)
                    .font(.system(size: 32, weight: .bold))
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
