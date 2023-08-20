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
    case decodingError
    case secretePlistError
}

final class LanguageModel: ObservableObject {
    static let shared = LanguageModel()
    private init(){}
    // 여행자 언어
    var sourceLangType: String = "en"
    // 운전자 언어
    var targetLangType: String = "ko"
    
    private var id: String? {
        guard let url = Bundle.main.url(forResource: "PapagoAPI", withExtension: "plist") else { return nil }
        guard let dictionary = try? NSDictionary(contentsOf: url, error: ()) else { return nil }
        return dictionary[String.id] as? String
    }
    
    private var secrete: String? {
        guard let url = Bundle.main.url(forResource: "PapagoAPI", withExtension: "plist") else { return "" }
        guard let dictionary = try? NSDictionary(contentsOf: url, error: ()) else { return "" }
        return dictionary[String.secrete] as? String
    }
    
    @Published var translatedText = "번역하기 전 말이 여기 있습니다."
    
    // fetch translation
    func fetchTranslation(with text: String) async throws {
        // Info.plist settup
        guard let id, let secrete else { throw TranslationError.secretePlistError }
        
        // 요청 URL
        guard let apiUrl = URL(string: "https://openapi.naver.com/v1/papago/n2mt") else { throw TranslationError.invalidURL }
        
        // 요청 데이터 설정
        let requestBody = "source=\(sourceLangType)&target=\(targetLangType)&text=\(text)"
        let requestData = requestBody.data(using: .utf8)
        
        // 요청 헤더 설정
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("\(id)", forHTTPHeaderField: String.id)
        request.addValue("\(secrete)", forHTTPHeaderField: String.secrete)
        request.httpBody = requestData

        // Rest API 요청
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // 데이터 정확도
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode  else {
            print(response)
            throw TranslationError.invalidResponse
        }
        guard let papagoReseponse = try? JSONDecoder().decode(PapagoResponse.self, from: data) else {
            throw TranslationError.decodingError }
        DispatchQueue.main.async { [unowned self] in
            print(papagoReseponse.message.result.translatedText)
            self.translatedText = papagoReseponse.message.result.translatedText
        }
    }
}

private extension String {
    static let id = "X-Naver-Client-Id"
    static let secrete = "X-Naver-Client-Secret"
}
