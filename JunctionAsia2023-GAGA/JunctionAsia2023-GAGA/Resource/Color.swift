//
//  Color.swift
//  JunctionAsia2023-GAGA
//
//  Created by Gucci on 2023/08/19.
//
import SwiftUI

extension Color {
    /// function: hex to color
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
    
    static func custom(_ color: CustomColor) -> Color {
        switch color{
        case .white:
            return Color(hex: "ffffff")
        case .gray100:
            return Color(hex: "F7F8F9")
        case .gray200:
            return Color(hex: "E9EBEE")
        case .gray300:
            return Color(hex: "C5C8CE")
        case .gray400:
            return Color(hex: "646F7C")
        case .gray500:
            return Color(hex: "374553")
        case .gray600:
            return Color(hex: "28323C")
        case .gray700:
            return Color(hex: "161D24")
        case .primary:
            return Color(hex: "6E65F4")
        case .primaryLight:
            return Color(hex: "A9A3FB")
        case .secondary:
            return Color(hex: "0B033F")
        case .background:
            return Color(hex: "E2E2E2")
        }
    }
}

enum CustomColor {
    case white
    case gray100
    case gray200
    case gray300
    case gray400
    case gray500
    case gray600
    case gray700
    
    case primary
    case primaryLight
    case secondary
    case background
}
