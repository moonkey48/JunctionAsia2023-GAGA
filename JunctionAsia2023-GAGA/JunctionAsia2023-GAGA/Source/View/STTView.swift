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
    @State private var isRecording = false
    @State private var smallCircleSize: CGFloat = 0.8
    @State private var bigCircleSize: CGFloat = 1
    @State private var sttState: STTState = .listening
    @State private var selectedGuide = guideSentences.randomElement() ?? ""
    
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
                            
                        }
                        STTButtonComponentView(contentText: "다시녹음", buttonType: .reTranscribing) {
                            
                        }
                    }
                    .padding()
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
