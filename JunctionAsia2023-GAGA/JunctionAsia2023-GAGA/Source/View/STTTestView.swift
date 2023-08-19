//
//  STTTestView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Seungui Moon on 2023/08/19.
//

import SwiftUI

struct STTTestView: View {
    @ObservedObject private var speachData = SpeechData.shared
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    
    var body: some View {
        VStack {
            Text(speachData.speachText)
            Button {
                speechRecognizer.stopTranscribing()
            } label: {
                Text("stop")
            }
            Button {
                speechRecognizer.resetTranscript()
            } label: {
                Text("reset")
            }
            Button {
                speechRecognizer.startTranscribing()
            } label: {
                Text("start")
            }
        }
    }
}

struct STTTestView_Previews: PreviewProvider {
    static var previews: some View {
        STTTestView()
    }
}
