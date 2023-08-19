//
//  STTView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Seungui Moon on 2023/08/19.
//

import SwiftUI

enum STTState {
    case listening
    case loading
    case done
}
let guideSentences = [
    "기사님과 이렇게 소통해보세요!",
    "이 주소로 가주세요.",
    "포항에서 유명한 맛집 추천해주세요!",
    "얼마나 걸리나요?"
]

struct STTView: View {
    @Binding var showSTTModal: Bool
    @StateObject private var textSession = TextMultipeerSession.shared
    @ObservedObject private var papagoModel = LanguageModel.shared
    @ObservedObject private var speechData = SpeechData.shared
    @StateObject var speechRecognizer = SpeechRecognizer()
    @ObservedObject var driverRecognizer: CommandRecognizer
    @ObservedObject private var driverCommandViewModel = DriverCommandViewModel.shared
    @State private var isRecording = false
    @State private var smallCircleSize: CGFloat = 0.8
    @State private var bigCircleSize: CGFloat = 1
    @State private var sttState: STTState = .listening
    @State private var selectedGuide = guideSentences.randomElement() ?? ""
    @State private var time = 0
    @State private var timer: Timer?
    @State private var recognizedText = ""
    
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
            
            switch sttState {
            case .done:
                Spacer()
            default:
                sttAnimationCircleView
            }
            
            VStack {
                if !textSession.currentText.isEmpty {
                    Text(textSession.currentText)
                        .foregroundColor(.white)
                }
                Spacer()
                    .frame(height: 100)
                HStack {
                    if recognizedText.isEmpty {
                        Text(speechData.speechText.isEmpty ? "말씀하시면 텍스트가 입력됩니다. " : speechData.speechText)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 24))
                    } else {
                        Text(recognizedText)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 24))
                    }
                    Spacer()
                }
                .padding()
                Spacer()
                if sttState != .done {
                    Text(selectedGuide)
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                }
                Spacer()
                    .frame(height: 240)
                switch sttState {
                case .listening:
                    listeningView
                case .loading:
                    loadingButton
                case .done:
                    EmptyView()
                }
            }
            
        }
        .onAppear {
            startRecognize()
            circleAnimationStart()
        }
        .onChange(of: speechData.speechText) { _ in
            self.time = 0
        }
        .onChange(of: time) { newValue in
            if newValue > 4 {
                if speechData.speechText.isEmpty {
                    time = 0
                } else {
                    startRecognizeCommand()
                    sttState = .loading
                }
            }
        }
        .onChange(of: driverCommandViewModel.driverCommand) { command in
            handleCommand(command)
        }
        .onChange(of: papagoModel.translatedText) { translatedText in
            textSession.send(text: translatedText)
            showSTTModal = false
        }
    }
    
    private func translate(value: String){
        Task {
            do {
                try await papagoModel.fetchTranslation(with: value)
            } catch {
                print("error on papago")
            }
        }
    }
    
    private func startRecognizeCommand(){
        recognizedText = speechData.speechText
        translate(value: speechData.speechText)
        print("stop recognizing and start command")
        speechRecognizer.resetTranscript()
        timer?.invalidate()
        driverRecognizer.startTranscribing()
    }
    
    private func handleCommand(_ command: DriverCommand){
        print(command.rawValue)
        switch command {
        case .start:
            startRecognize()
        case .reset:
            startRecognize()
        case .restart:
            startRecognize()
        case .close:
            endRecognize()
        case .notDefined:
            return
        }
    }
    private func endRecognize(){
        timer?.invalidate()
        driverRecognizer.resetTranscript()
        driverCommandViewModel.driverCommand = .notDefined
        speechRecognizer.resetTranscript()
    }
    
    private func startRecognize(){
        // timer setting
        sttState = .listening
        recognizedText = ""
        time = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.time += 1
        }
        // stop driver command
        driverRecognizer.resetTranscript()
        driverCommandViewModel.driverCommand = .notDefined
        
        // start recognize
        speechRecognizer.startTranscribing()
    }
    
    private func circleAnimationStart(){
        withAnimation(.easeInOut(duration: 1.5).repeatForever()) {
            smallCircleSize = 0.6
        }
        withAnimation(.easeInOut(duration: 1.5).repeatForever()) {
            bigCircleSize = 0.8
        }
    }
}
extension STTView {
    var listeningView: some View {
        Image("sttListening")
            .resizable()
            .scaledToFit()
            .frame(width: 156, height: 156)
    }
    var loadingButton: some View {
        ProgressView()
            .foregroundColor(.white)
            .frame(width: 156, height: 156)
            .controlSize(.large)
            .scaleEffect(2)
            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
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

struct STTPreview: View {
    @State private var showSTTModal = false
    @StateObject private var driverRecognizer = CommandRecognizer()
    var body: some View {
        STTView(showSTTModal: $showSTTModal, driverRecognizer: driverRecognizer)
    }
}

struct STTView_Previews: PreviewProvider {
    static var previews: some View {
        STTPreview()
    }
}
