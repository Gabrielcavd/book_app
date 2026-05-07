//
//  GoogleBooksAPIService.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 04/05/26.
//

import Foundation

struct GoogleBooksAPIService {
    private static let fieldsQueryValue = "kind,totalItems,items(id,volumeInfo(title,authors,publishedDate,description,pageCount,categories,language,averageRating,imageLinks(smallThumbnail)))"

    private let networkClient: NetworkClient
    private let decoder: JSONDecoder

    init(networkClient: NetworkClient, decoder: JSONDecoder = JSONDecoder()) {
        self.networkClient = networkClient
        self.decoder = decoder
    }

    static func live(bundle: Bundle = .main) throws -> GoogleBooksAPIService {
        let networkConfig = try NetworkConfig.googleBooks(bundle: bundle)
        let networkClient = NetworkClient(configuration: networkConfig)
        return GoogleBooksAPIService(networkClient: networkClient)
    }

    func findAll(
        title: String = "",
        genre: String = "",
        author: String = ""
    ) async throws -> [BookModel] {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedGenre = genre.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedAuthor = author.trimmingCharacters(in: .whitespacesAndNewlines)

        var queryTerms: [String] = []
        if !trimmedGenre.isEmpty {
            queryTerms.append("subject:\(trimmedGenre)")
        }
        if !trimmedTitle.isEmpty {
            queryTerms.append("intitle:\(trimmedTitle)")
        }
        if !trimmedAuthor.isEmpty {
            queryTerms.append("inauthor:\(trimmedAuthor)")
        }

        guard !queryTerms.isEmpty else {
            throw NetworkError.invalidQuery
        }

        guard let apiKey = networkClient.configuration.apiKey else {
            throw NetworkError.missingConfiguration("GOOGLE_BOOKS_API_KEY")
        }

        let requiredQueryItems: [URLQueryItem] = [
            URLQueryItem(name: "fields", value: Self.fieldsQueryValue),
            URLQueryItem(name: "maxResults", value: "40"),
            URLQueryItem(name: "printType", value: "books"),
            URLQueryItem(name: "langRestrict", value: "pt"),
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: queryTerms.joined(separator: "+")),
        ]

        let request = NetworkRequest(
            path: "/volumes",
            method: .get,
            queryItems: requiredQueryItems
        )

        let data = try await networkClient.send(request)

        do {
            let response = try decoder.decode(GoogleBooksFindAllResponseDTO.self, from: data)
            return response.items
                .map(BookModel.init(dto:))
                .filter { book in
                    !book.smallThumbnail.isEmpty && !book.smallThumbnail.contains("file://")
                }
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}

private extension BookModel {
    init(dto: GoogleBooksItemDTO) {
        self.id = dto.id
        self.title = dto.volumeInfo.title
        self.authors = dto.volumeInfo.authors
        self.publishedDate = dto.volumeInfo.publishedDate
        self.description = dto.volumeInfo.description
        self.pageCount = dto.volumeInfo.pageCount
        self.categories = dto.volumeInfo.categories
        self.language = dto.volumeInfo.language
        self.smallThumbnail = dto.volumeInfo.imageLinks?.smallThumbnail ?? ""
        self.averageRating = dto.volumeInfo.averageRating
    }
}
