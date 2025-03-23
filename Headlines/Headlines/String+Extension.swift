import Foundation

extension String {
    var url: URL? {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return nil }
        let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: (self as NSString).length))
        return matches.first?.url
    }
    
    var dateFromISO8601: Date? {
        return ISO8601DateFormatter.standard.date(from: self)
    }
    var dateFromDDMMYYYY: Date? {
        // Using the shared formatter for better performance
        return DateFormatter.ddMMyyyyTime.date(from: self)
    }
}
