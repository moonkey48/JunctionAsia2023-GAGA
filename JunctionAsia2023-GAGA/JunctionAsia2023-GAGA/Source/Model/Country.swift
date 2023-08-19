//
//  Country.swift
//  JunctionAsia2023-GAGA
//
//  Created by Gucci on 2023/08/20.
//

import Foundation

enum Country: String, CaseIterable {
    case uk, germany, france, spain, italy, korea
    
    var flag: String {
        self.rawValue
    }
    
    var language: String {
        switch self {
        case .uk:
            return "English"
        case .germany:
            return "Deutsch"
        case .france:
            return "Français"
        case .spain:
            return "Español"
        case .italy:
            return "Italiano"
        case .korea:
            return "한국어"
        }
    }
}
