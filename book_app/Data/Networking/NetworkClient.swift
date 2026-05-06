//
//  NetworkClient.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 04/05/26.
//

import Foundation

struct NetworkClient {
    let configuration: NetworkConfig
    private let session: URLSession

    init(configuration: NetworkConfig, session: URLSession = .shared) {
        self.configuration = configuration
        self.session = session
    }

    func send(_ request: NetworkRequest) async throws -> Data {
        var components = URLComponents(url: configuration.baseURL, resolvingAgainstBaseURL: false)
        components?.path = configuration.baseURL.path + request.path
        components?.queryItems = request.queryItems.isEmpty ? nil : request.queryItems

        guard let finalURL = components?.url else {
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body

        for (field, value) in request.headers {
            urlRequest.setValue(value, forHTTPHeaderField: field)
        }

        do {
            let (data, response) = try await session.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.statusCode(httpResponse.statusCode)
            }

            guard !data.isEmpty else {
                throw NetworkError.emptyResponseData
            }

            return data
        } catch let networkError as NetworkError {
            throw networkError
        } catch {
            throw NetworkError.unknown
        }
    }
}
