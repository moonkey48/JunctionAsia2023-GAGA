//
//  PirmaryButtonStyle.swift
//  JunctionAsia2023-GAGA
//
//  Created by Gucci on 2023/08/20.
//

import SwiftUI

struct PrimaryButtonStyle: ViewModifier {
    let isSelected: Bool
    
    func body(content: Content) -> some View {
        content
            .font(.bodySemibold)
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width, height: 56)
            .background(isSelected ? Color.custom(.primary) : Color.custom(.primaryLight))
            .padding(.horizontal, -16)
            .cornerRadius(12)
    }
}

extension View {
    func primaryButtonStyle(isSelected: Bool) -> some View {
        modifier(PrimaryButtonStyle(isSelected: isSelected))
    }
}
