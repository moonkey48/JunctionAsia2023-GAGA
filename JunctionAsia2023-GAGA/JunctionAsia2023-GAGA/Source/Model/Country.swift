//
//  Country.swift
//  JunctionAsia2023-GAGA
//
//  Created by Gucci on 2023/08/20.
//

import Foundation

enum Country: String, CaseIterable {
    case uk, germany, france, spain, italy, unknown
    
    var flag: String {
        self.rawValue
    }
    
    var language: String {
        switch self {
        case .uk:
            return "English"
        case .germany:
            return "German"
        case .france:
            return "Franch"
        case .spain:
            return "Spanish"
        case .italy:
            return "Italian"
        case .unknown:
            return "Unknown"
        }
    }
}
