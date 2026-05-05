//
//  ReadingStatus.swift
//  book_app
//
//  Created by Gabriel Merenfeld on 28/04/26.
//

enum ReadingStatus: String, CaseIterable, Hashable, DropdownOption {
    case notRead = "Não li"
    case readLater = "Ler depois"
    case alreadyRead = "Já li"
    case startReading = "Começar a ler"
    
    var title: String { rawValue }
    
    var icon: String {
        switch self {
        case .notRead:
            return "questionmark"
        case .readLater:
            return "bookmark"
        case .alreadyRead:
            return "checkmark"
        case .startReading:
            return "book.closed"
        }
    }
}
