//
//  MCTestView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Seungui Moon on 2023/08/19.
//

import SwiftUI

struct MCTestView: View {
    @StateObject private var textSession = TextMultipeerSession()
    private let testTextList = ["hello", "WTF"]
    
    var body: some View {
        VStack(alignment: .leading) {
                   Text("Connected Devices:")
            Text(String(describing: textSession.connectedPeers.map(\.description)))
            Text(textSession.currentText)
                   Divider()

                   HStack {
                       ForEach(testTextList, id: \.self) { text in
                           Button(text) {
                               textSession.send(text: text)
                           }
                           .padding()
                       }
                   }
                   Spacer()
               }
               .padding()
    }
}

struct MCTestView_Previews: PreviewProvider {
    static var previews: some View {
        MCTestView()
    }
}
