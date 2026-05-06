//
//  NetworkConfig.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 04/05/26.
//

import Foundation

struct NetworkConfig {
    let baseURL: URL
    let apiKey: String?

    init(baseURL: URL, apiKey: String? = nil) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
}

extension NetworkConfig {
    static func googleBooks(bundle: Bundle = .main) throws -> NetworkConfig {
        guard let baseURL = URL(string: "https://www.googleapis.com/books/v1") else {
            throw NetworkError.invalidURL
        }

        let apiKey = runtimeValue(for: "GOOGLE_BOOKS_API_KEY", in: bundle)
        return NetworkConfig(baseURL: baseURL, apiKey: apiKey)
    }

    private static func runtimeValue(for key: String, in bundle: Bundle) -> String? {
        guard let rawValue = bundle.object(forInfoDictionaryKey: key) as? String else {
            return nil
        }

        let value = rawValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !value.isEmpty else { return nil }
        
        if value.hasPrefix("$(") && value.hasSuffix(")") {
            return nil
        }

        return value
    }
}
