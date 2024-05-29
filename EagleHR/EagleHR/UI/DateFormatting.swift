//
// Created by Katarina Dokic
//

import Foundation

enum DateFormatting {
    static func toUserFriendlyDateFormat(_ dateString: String) -> String {
        let userFriendlyDateFormatter = DateFormatter()
        userFriendlyDateFormatter.dateFormat = "dd/mm/yyyy"

        let isoDateFormatter = DateFormatter()
        isoDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let date = isoDateFormatter.date(from: dateString)
        guard let date else {
            assertionFailure("Failed to parse \(dateString) as date")
            return dateString
        }
        return userFriendlyDateFormatter.string(from: date)
    }
}
