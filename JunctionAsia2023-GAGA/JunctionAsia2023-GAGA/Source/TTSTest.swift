//
//  TTSTest.swift
//  JunctionAsia2023-GAGA
//
//  Created by Lee Juwon on 2023/08/19.
//

import SwiftUI
import AVFoundation


struct TTSTest: View {
    let synthesizer = AVSpeechSynthesizer()
    @State private var textToRead: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter text", text: $textToRead)
                .padding()
            
            Button("Read Text") {
                // Stop any ongoing speech
                synthesizer.stopSpeaking(at: .immediate)
                
                // Create an AVSpeechUtterance with the text to read
                let utterance = AVSpeechUtterance(string: textToRead)
                
                // Configure voice and language for Korean TTS
                utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
                
                // Start speech synthesis
                synthesizer.speak(utterance)
                
                // Print a message to the console to indicate TTS is working (for simulator)
                print("Text will be spoken: \(textToRead)")
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
