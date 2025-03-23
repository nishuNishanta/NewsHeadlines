import UIKit

struct GuardianAPIResponse: Decodable {
    struct Results: Decodable {
        let results: [Article]
        let currentPage: Int
        let pages: Int
    }
    let response: Results
}

struct Article: Decodable {
    let webTitle: String
    let webPublicationDate: String
    var imageURL: URL? { fields.main.url }
    var description: String? { fields.body }
    private let fields: Fields

    
    var formattedPublicationDate : String {
        if let formattedDate = webPublicationDate.dateFromISO8601 {
            return formattedDate.formattedDDMMYYY
        }
        return webPublicationDate
    }
    
    var publicationYear: Int {
        if let date = webPublicationDate.dateFromISO8601 {
            return date.year
        }
        return Calendar.current.component(.year, from: Date())
    }
    
    struct Fields: Decodable {
        let main: String
        let body: String
    }
}
