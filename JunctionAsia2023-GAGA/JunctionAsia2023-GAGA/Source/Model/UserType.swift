//
//  UserType.swift
//  JunctionAsia2023-GAGA
//
//  Created by Gucci on 2023/08/20.
//

import Foundation

enum UserType: String, CaseIterable {
    case tourist, driver, unknown
    
    var text: String { self.rawValue }
    var imageString: String {
        switch self {
        case .driver:
            return "👨🏻‍✈️"
        case .tourist:
            return "🧑🏻‍"
        case .unknown:
            return "Unknown"
        }
    }
}
