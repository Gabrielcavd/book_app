//
//  GoogleBooksFindAllResponseDTO.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 04/05/26.
//

import Foundation

struct GoogleBooksFindAllResponseDTO: Decodable {
    let kind: String
    let totalItems: Int
    let items: [GoogleBooksItemDTO]

    private enum CodingKeys: String, CodingKey {
        case kind
        case totalItems
        case items
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        kind = try container.decode(String.self, forKey: .kind)
        totalItems = try container.decode(Int.self, forKey: .totalItems)
        items = try container.decodeIfPresent([GoogleBooksItemDTO].self, forKey: .items) ?? []
    }
}

struct GoogleBooksItemDTO: Decodable {
    let id: String
    let volumeInfo: GoogleBooksVolumeInfoDTO
}

struct GoogleBooksVolumeInfoDTO: Decodable {
    let title: String
    let authors: [String]
    let publishedDate: String?
    let description: String?
    let pageCount: Int?
    let categories: [String]
    let language: String?
    let averageRating: Double?
    let imageLinks: GoogleBooksImageLinksDTO?

    private enum CodingKeys: String, CodingKey {
        case title
        case authors
        case publishedDate
        case description
        case pageCount
        case categories
        case language
        case imageLinks
        case averageRating
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        authors = try container.decodeIfPresent([String].self, forKey: .authors) ?? []
        publishedDate = try container.decodeIfPresent(String.self, forKey: .publishedDate)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        pageCount = try container.decodeIfPresent(Int.self, forKey: .pageCount)
        categories = try container.decodeIfPresent([String].self, forKey: .categories) ?? []
        language = try container.decodeIfPresent(String.self, forKey: .language)
        imageLinks = try container.decodeIfPresent(GoogleBooksImageLinksDTO.self, forKey: .imageLinks)
        averageRating = try container.decodeIfPresent(Double.self, forKey: .averageRating)
    }
}

struct GoogleBooksImageLinksDTO: Decodable {
    let smallThumbnail: String?
}
