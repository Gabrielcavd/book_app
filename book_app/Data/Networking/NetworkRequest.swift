//
//  NetworkRequest.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 04/05/26.
//

import Foundation

struct NetworkRequest {
    let path: String
    let method: HTTPMethod
    var headers: [String: String]
    var queryItems: [URLQueryItem]
    var body: Data?

    init(
        path: String,
        method: HTTPMethod,
        headers: [String: String] = [:],
        queryItems: [URLQueryItem] = [],
        body: Data? = nil
    ) {
        self.path = path
        self.method = method
        self.headers = headers
        self.queryItems = queryItems
        self.body = body
    }
}
