//
//  TTSView.swift
//  JunctionAsia2023-GAGA
//
//  Created by Lee Juwon on 2023/08/19.
//

import SwiftUI

struct TTSView: View {
    
    @State private var text = ""
    
    var body: some View {
        VStack {
            TextField("내용을 입력해주세요", text: $text)
                .frame(width: 358, height: 360)
                .cornerRadius(16)
            
            Rectangle()
                .frame(width: 368, height: 56)
                .cornerRadius(12)
        }
        
        
        
    }
}

struct TTSView_Previews: PreviewProvider {
    static var previews: some View {
        TTSView()
    }
}
