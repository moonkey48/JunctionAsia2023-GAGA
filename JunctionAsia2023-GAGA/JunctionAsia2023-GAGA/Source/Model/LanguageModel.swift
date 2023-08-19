//
//  LanguageModel.swift
//  JunctionAsia2023-GAGA
//
//  Created by Gucci on 2023/08/19.
//

import Foundation

enum TranslationError: Error {
    case invalidURL
    case sourceEmpty
    case targetEmpty
    case contentEmpty
    case invalidResponse
}

final class LanguageModel: ObservableObject {
    // 여행자 언어
    private let sourceLangType: String = "en"
    // 운전자 언어
    private let targetLangType: String = "ko"
    
    
    func fetchTranslation(from source: String, to target: String,  with text: String) async throws -> String {
        // 요청 URL
        guard let apiUrl = URL(string: "https://openapi.naver.com/v1/papago/n2mt") else { throw TranslationError.invalidURL }
        
        // 요청 데이터 설정
        let requestBody = "source=\(source)&target=\(target)&text=\(text)"
        let requestData = requestBody.data(using: .utf8)
        
        // 요청 헤더 설정
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("{애플리케이션 등록 시 발급받은 클라이언트 아이디 값}", forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue("{애플리케이션 등록 시 발급받은 클라이언트 시크릿 값}", forHTTPHeaderField: "X-Naver-Client-Secret")


        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode  else { throw TranslationError.invalidResponse }
        
        return ""
    }
}

// Info.plist에 시크릿 담기
