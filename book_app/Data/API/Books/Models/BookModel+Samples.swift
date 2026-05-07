//
//  BookModel+Samples.swift
//  book_app
//
//  Local sample books for Home / Library until backed by real persistence.
//

import Foundation

extension BookModel {
    /// Stable IDs for navigation and previews (not from Google Books API).
    static let sampleSenhorDosAneis = BookModel(
        id: "sample-senhor-dos-aneis",
        title: "O Senhor dos Anéis",
        authors: ["J.R.R. Tolkien"],
        publishedDate: "1954-07-29",
        description: "Uma epopeia de fantasia que narra a busca para destruir o Um Anel.",
        pageCount: 1178,
        categories: ["Fantasia", "Ficção"],
        language: "pt",
        smallThumbnail: "",
        averageRating: 4.8
    )

    static let sampleDomCasmurro = BookModel(
        id: "sample-dom-casmurro",
        title: "Dom Casmurro",
        authors: ["Machado de Assis"],
        publishedDate: "1899",
        description: "Romance realista sobre ciúme e dúvida narrado por Bentinho.",
        pageCount: 256,
        categories: ["Romance", "Clássico"],
        language: "pt",
        smallThumbnail: "",
        averageRating: 4.5
    )

    static let sampleRevolucaoBichos = BookModel(
        id: "sample-revolucao-dos-bichos",
        title: "A Revolução dos Bichos",
        authors: ["George Orwell"],
        publishedDate: "1945-08-17",
        description: "Uma fábula satírica sobre poder e corrupção.",
        pageCount: 152,
        categories: ["Ficção política"],
        language: "pt",
        smallThumbnail: "",
        averageRating: 4.6
    )

    static let samplePequenoPrincipe = BookModel(
        id: "sample-pequeno-principe",
        title: "O Pequeno Príncipe",
        authors: ["Antoine de Saint-Exupéry"],
        publishedDate: "1943",
        description: "Uma história poética sobre amizade e o essencial invisível aos olhos.",
        pageCount: 96,
        categories: ["Fábula", "Infantil"],
        language: "pt",
        smallThumbnail: "",
        averageRating: 4.9
    )

    static let sample1984 = BookModel(
        id: "sample-1984",
        title: "1984",
        authors: ["George Orwell"],
        publishedDate: "1949-06-08",
        description: "Distopia sobre vigilância totalitária e manipulação da verdade.",
        pageCount: 416,
        categories: ["Ficção científica", "Distopia"],
        language: "pt",
        smallThumbnail: "",
        averageRating: 4.7
    )

    static let sampleHarryPotter = BookModel(
        id: "sample-harry-potter-1",
        title: "Harry Potter e a Pedra Filosofal",
        authors: ["J.K. Rowling"],
        publishedDate: "1997-06-26",
        description: "O início da saga do jovem bruxo Harry Potter em Hogwarts.",
        pageCount: 223,
        categories: ["Fantasia", "Juvenil"],
        language: "pt",
        smallThumbnail: "",
        averageRating: 4.8
    )

    static let samplePacienteSilenciosa = BookModel(
        id: "sample-paciente-silenciosa",
        title: "A Paciente Silenciosa",
        authors: ["Alex Michaelides"],
        publishedDate: "2019-02-05",
        description: "Thriller psicológico sobre um crime e uma artista que deixa de falar.",
        pageCount: 336,
        categories: ["Suspense", "Thriller"],
        language: "pt",
        smallThumbnail: "",
        averageRating: 4.2
    )

    static let sampleMemoriasBrasCubas = BookModel(
        id: "sample-memorias-bras-cubas",
        title: "Memórias Póstumas de Brás Cubas",
        authors: ["Machado de Assis"],
        publishedDate: "1881",
        description: "Romance inovador narrado por um defunto autor.",
        pageCount: 288,
        categories: ["Romance", "Clássico"],
        language: "pt",
        smallThumbnail: "",
        averageRating: 4.6
    )

    /// Carousel / home row samples.
    static let homeCarouselSamples: [BookModel] = [
        .sampleSenhorDosAneis,
        .sampleDomCasmurro,
        .sampleRevolucaoBichos,
        .samplePequenoPrincipe,
    ]
}
