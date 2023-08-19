//
//  ReceivedTextView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Seungui Moon on 2023/08/20.
//

import SwiftUI

struct ReceivedTextView: View {
    @ObservedObject private var mcSession = TextMultipeerSession.shared
    var body: some View {
        VStack(alignment: .leading) {
            Text(mcSession.currentText)
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 30)
            Spacer()
            HStack() {
                retryButton
                answerButton
            }
        }
        .padding()
    }
}
extension ReceivedTextView {
    var retryButton: some View {
        VStack(alignment: .leading) {
            Text("다시 듣기")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
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
            Text("답장하기")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
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

struct ReceivedTextView_Previews: PreviewProvider {
    static var previews: some View {
        ReceivedTextView()
    }
}
