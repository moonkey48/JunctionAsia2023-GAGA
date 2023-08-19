//
//  UserType.swift
//  JunctionAsia2023-GAGA
//
//  Created by Gucci on 2023/08/20.
//

import Foundation

enum UserType: String, CaseIterable {
    case passenger, driver
    
    var text: String { self.rawValue.capitalized }
    var imageString: String {
        switch self {
        case .driver:
            return "👨🏻‍✈️"
        case .passenger:
            return "🧑🏻‍"
        }
    }
}
