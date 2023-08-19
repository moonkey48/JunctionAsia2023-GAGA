//
//  CommandTestView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Seungui Moon on 2023/08/19.
//

import SwiftUI

struct CommandTestView: View {
//    @ObservedObject private var speechData = SpeechData.shared
//    @StateObject var speechRecognizer = SpeechRecognizer()
    @ObservedObject private var driverCommandViewModel = DriverCommandViewModel.shared
    @StateObject var commandRecognizer = CommandRecognizer()
    @State private var showModal = false
    
    var body: some View {
        VStack {
            Text(driverCommandViewModel.driverCommand.rawValue)
        }
        .onAppear {
            print("start recognize")
            commandRecognizer.startTranscribing()
        }
        .sheet(isPresented: $showModal, content: {
            VStack {
                Text("this is modal")
                Text(driverCommandViewModel.driverCommand.rawValue)
            }
        })
        .onChange(of: driverCommandViewModel.driverCommand) { newCommand in
        
            switch newCommand {
            case .start:
                showModal = true
            case .restart:
                showModal = true
            case .reset:
                showModal = false
            case .close:
                showModal = false
            case .notDefined:
                return
            }
        }
        .onChange(of: showModal) { _ in
            commandRecognizer.resetTranscript()
            driverCommandViewModel.driverCommand = .notDefined
            commandRecognizer.startTranscribing()
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
                commandRecognizer.stopTranscribing()
                commandRecognizer.resetTranscript()
                driverCommandViewModel.driverCommand = .notDefined
                commandRecognizer.startTranscribing()
            }
        }
    }
}

struct CommandTestView_Previews: PreviewProvider {
    static var previews: some View {
        CommandTestView()
    }
}
