//
//  MainViewSTTRecognizer.swift
//  JunctionAsia2023-GAGA
//
//  Created by Seungui Moon on 2023/08/20.
//

import Foundation
import AVFoundation
import Speech
import SwiftUI

enum MainViewCommands: String {
    case sttCommand = "시작"
    case ttsCommand = "텍스트"
    case closeCommand = "취소"
    case restartCommand = "다시"
    case notDefined = ""
}


final class MainViewCommandViewModel: ObservableObject {
    static let shared = MainViewCommandViewModel()
    private init(){}
    
    @Published var mainViewCommand: MainViewCommands = .notDefined
    @Published var currentLocale: LocaleSupport = .korea
}


actor MainViewSTTRecognizer: ObservableObject {
    let mainViewCommandViewModel = MainViewCommandViewModel.shared
    enum RecognizerError: Error {
        case nilRecognizer
        case notAuthorizedToRecognize
        case notPermittedToRecord
        case recognizerIsUnavailable
        
        var message: String {
            switch self {
            case .nilRecognizer: return "Can't initialize speech recognizer"
            case .notAuthorizedToRecognize: return "Not authorized to recognize speech"
            case .notPermittedToRecord: return "Not permitted to record audio"
            case .recognizerIsUnavailable: return "Recognizer is unavailable"
            }
        }
    }
    @MainActor var transcript: String = ""
    
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private let recognizer: SFSpeechRecognizer?
    
    /**
     Initializes a new speech recognizer. If this is the first time you've used the class, it
     requests access to the speech recognizer and the microphone.
     */
    init() {
        
        recognizer = SFSpeechRecognizer(locale: Locale(identifier: mainViewCommandViewModel.currentLocale.rawValue))
        
        
        guard recognizer != nil else {
            transcribe(RecognizerError.nilRecognizer)
            return
        }
        
        Task {
            do {
                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
                    throw RecognizerError.notAuthorizedToRecognize
                }
                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else {
                    throw RecognizerError.notPermittedToRecord
                }
            } catch {
                transcribe(error)
            }
        }
    }
    
    @MainActor func startTranscribing() {
        Task {
            await transcribe()
        }
    }
    
    @MainActor func resetTranscript() {
        Task {
            await reset()
        }
    }
    
    @MainActor func stopTranscribing() {
        Task {
            await reset()
        }
    }
    
    /**
     Begin transcribing audio.
     
     Creates a `SFSpeechRecognitionTask` that transcribes speech to text until you call `stopTranscribing()`.
     The resulting transcription is continuously written to the published `transcript` property.
     */
    private func transcribe() {
        guard let recognizer, recognizer.isAvailable else {
            self.transcribe(RecognizerError.recognizerIsUnavailable)
            return
        }
        
        do {
            let (audioEngine, request) = try Self.prepareEngine()
            self.audioEngine = audioEngine
            self.request = request
            self.task = recognizer.recognitionTask(with: request, resultHandler: { [weak self] result, error in
                self?.setResult(result: result)
                self?.recognitionHandler(audioEngine: audioEngine, result: result, error: error)
            })
        } catch {
            self.reset()
            self.transcribe(error)
        }
    }
    
    /// Reset the speech recognizer.
    private func reset() {
        task?.cancel()
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
    }
    
    private static func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.playAndRecord, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            request.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()
        
        return (audioEngine, request)
    }
    private func setResult(result: SFSpeechRecognitionResult?) {
        let receivedFinalResult = result?.bestTranscription.formattedString
        let seperated = receivedFinalResult?.split(separator: " ").last
        guard let seperated = seperated else {
            return
        }
        print(seperated)
        if seperated == MainViewCommands.sttCommand.rawValue   {
            mainViewCommandViewModel.mainViewCommand = .sttCommand
        } else if seperated == MainViewCommands.ttsCommand.rawValue   {
            mainViewCommandViewModel.mainViewCommand = .ttsCommand
        } else if seperated == MainViewCommands.closeCommand.rawValue   {
            mainViewCommandViewModel.mainViewCommand = .closeCommand
        } else if seperated == MainViewCommands.restartCommand.rawValue   {
            mainViewCommandViewModel.mainViewCommand = .restartCommand
        } else {
            mainViewCommandViewModel.mainViewCommand = .notDefined
        }
        
    }
    
    nonisolated private func recognitionHandler(audioEngine: AVAudioEngine, result: SFSpeechRecognitionResult?, error: Error?) {
        let receivedFinalResult = result?.isFinal ?? false
        let receivedError = error != nil
        
        if receivedFinalResult || receivedError {
            audioEngine.stop()
            audioEngine.inputNode.removeTap(onBus: 0)
        }
        
        if let result {
            transcribe(result.bestTranscription.formattedString)
        }
    }
    
    
    nonisolated private func transcribe(_ message: String) {
        Task { @MainActor in
            transcript = message
        }
    }
    nonisolated private func transcribe(_ error: Error) {
        var errorMessage = ""
        if let error = error as? RecognizerError {
            errorMessage += error.message
        } else {
            errorMessage += error.localizedDescription
        }
        Task { @MainActor [errorMessage] in
            transcript = "<< \(errorMessage) >>"
        }
    }
}

//
//extension SFSpeechRecognizer {
//    static func hasAuthorizationToRecognize() async -> Bool {
//        await withCheckedContinuation { continuation in
//            requestAuthorization { status in
//                continuation.resume(returning: status == .authorized)
//            }
//        }
//    }
//}
//
//
//extension AVAudioSession {
//    func hasPermissionToRecord() async -> Bool {
//        await withCheckedContinuation { continuation in
//            requestRecordPermission { authorized in
//                continuation.resume(returning: authorized)
//            }
//        }
//    }
//}



