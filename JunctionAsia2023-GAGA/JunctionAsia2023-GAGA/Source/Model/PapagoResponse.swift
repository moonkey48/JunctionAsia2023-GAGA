//
//  PapagoResponse.swift
//  JunctionAsia2023-GAGA
//
//  Created by Gucci on 2023/08/19.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let papagoResponse = try? JSONDecoder().decode(PapagoResponse.self, from: jsonData)
import Foundation

// MARK: - PapagoResponse
struct PapagoResponse: Codable {
    let message: Message
}

// MARK: - Message
struct Message: Codable {
    let type, service, version: String
    let result: Result

    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case service = "@service"
        case version = "@version"
        case result
    }
}

// MARK: - Result
struct Result: Codable {
    //  "ko"         "en"         "tea"
    let srcLangType, tarLangType, translatedText: String
}
