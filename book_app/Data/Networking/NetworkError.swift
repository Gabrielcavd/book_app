//
//  NetworkError.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 04/05/26.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidQuery
    case invalidResponse
    case statusCode(Int)
    case emptyResponseData
    case missingConfiguration(String)
    case decodingFailed
    case unknown
}
