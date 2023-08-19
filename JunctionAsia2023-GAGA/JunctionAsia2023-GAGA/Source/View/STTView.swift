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
    @ObservedObject private var speachData = SpeechData.shared
    @StateObject var speechRecognizer = SpeechRecognizer()
    @StateObject var driverRecognizer = CommandRecognizer()
    @ObservedObject private var driverCommandViewModel = DriverCommandViewModel.shared
    @State private var isRecording = false
    @State private var smallCircleSize: CGFloat = 0.8
    @State private var bigCircleSize: CGFloat = 1
    @State private var sttState: STTState = .listening
    @State private var selectedGuide = guideSentences.randomElement() ?? ""
    @State private var time = 0
    @State private var timer: Timer?
    
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
                Spacer()
                    .frame(height: 100)
                Text("\(time)")
                    .foregroundColor(.white)
                HStack {
                    Text(speachData.speachText.isEmpty ? "말씀하시면 텍스트가 입력됩니다. " : speachData.speachText)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 24))
                    Spacer()
                }
                .padding()
                Spacer()
                Text(selectedGuide)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                Spacer()
                    .frame(height: 240)
                switch sttState {
                case .listening:
                    Button {
                        speechRecognizer.resetTranscript()
                        speechRecognizer.startTranscribing()
                    } label: {
                        stopButton
                    }
                case .loading:
                    loadingButton
                case .done:
                    HStack {
                        STTButtonComponentView(contentText: "전달하기") {
                            // send data to mc
                        }
                        STTButtonComponentView(contentText: "다시녹음", buttonType: .reTranscribing) {
                            // restart recognize
                        }
                    }
                    .padding()
                }
            }
            
        }
        .onAppear {
            startRecognize()
            circleAnimationStart()
        }
        .onChange(of: speachData.speachText) { _ in
            self.time = 0
        }
        .onChange(of: time) { newValue in
            if newValue > 5 {
                startRecognizeCommand()
            }
        }
        .onChange(of: driverCommandViewModel.driverCommand) { command in
            print(command.rawValue)
//            handleCommand(newCommand)
        }
    }
    
    private func startRecognizeCommand(){
        print("stop recognizing and start command")
        speechRecognizer.resetTranscript()
        timer?.invalidate()
        driverRecognizer.startTranscribing()
//        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
//            driverRecognizer.resetTranscript()
//            driverCommandViewModel.driverCommand = .notDefined
//            driverRecognizer.startTranscribing()
//        }
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
    var loadingButton: some View {
        ZStack {
            Image("sttStopButton")
                .resizable()
                .frame(width: 156, height: 156)
            ProgressView()
                .foregroundColor(.white)
                .frame(width: 58, height: 58)
                .controlSize(.large)
                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
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

enum STTButtonType {
    case send
    case reTranscribing
}

struct STTButtonComponentView: View {
    var contentText: String
    var buttonType: STTButtonType = .send
    var buttonAction: () -> Void
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            HStack {
                Spacer()
                Text(contentText)
                    .frame(height: 36)
                Spacer()
            }
            .padding()
            .background(buttonType == .send ? Color(hex: "6E65F4") : .white)
            .foregroundColor(buttonType == .send ? .white : .black)
            .font(.system(size: 22, weight: .semibold))
            .cornerRadius(12)
        }
    }
}
