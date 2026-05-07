//
//  BookModel+Display.swift
//  book_app
//
//  Created for presentation-friendly book fields.
//

import Foundation

extension BookModel {
    /// HTTPS URL for cover image, if `smallThumbnail` is non-empty and valid.
    var coverImageURL: URL? {
        let normalized = smallThumbnail
            .replacingOccurrences(of: "http://", with: "https://")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        guard !normalized.isEmpty, let url = URL(string: normalized) else { return nil }
        return url
    }

    /// First author, or a localized fallback when missing.
    var primaryAuthorDisplay: String {
        let first = authors.first?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        return first.isEmpty ? "Autor desconhecido" : first
    }

    /// Comma-separated categories for UI, or a fallback.
    var genresDisplay: String {
        let trimmed = categories
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        guard !trimmed.isEmpty else { return "—" }
        return trimmed.joined(separator: ", ")
    }

    /// Page count for specs row, or fallback.
    var pageCountDisplay: String {
        guard let count = pageCount, count > 0 else { return "—" }
        return String(count)
    }

    /// User-visible rating; Google Books may omit this.
    var averageRatingDisplay: Double {
        averageRating ?? 0
    }

    /// Short label for star badge (e.g. "4.2").
    var averageRatingLabel: String {
        let value = averageRatingDisplay
        return value == 0 ? "—" : String(format: "%.1f", value)
    }

    /// Raw API date string formatted for display when parsable; otherwise returns the original or "—".
    func formattedPublishedDate(locale: Locale = Locale(identifier: "pt_BR")) -> String {
        guard let raw = publishedDate?.trimmingCharacters(in: .whitespacesAndNewlines), !raw.isEmpty else {
            return "—"
        }
        let posix = Locale(identifier: "en_US_POSIX")
        let patterns = ["yyyy-MM-dd", "yyyy-MM", "yyyy"]
        for pattern in patterns {
            let parser = DateFormatter()
            parser.dateFormat = pattern
            parser.locale = posix
            parser.timeZone = TimeZone(secondsFromGMT: 0)
            if let date = parser.date(from: raw) {
                let out = DateFormatter()
                out.dateStyle = .medium
                out.timeStyle = .none
                out.locale = locale
                return out.string(from: date)
            }
        }
        return raw
    }

    var descriptionDisplay: String {
        let text = description?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        return text.isEmpty ? "Sem descrição disponível." : text
    }
}
