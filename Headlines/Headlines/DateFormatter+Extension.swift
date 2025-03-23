//
//  DateFormatter+extension.swift
//  Headlines
//
//  Created by Nishu Nishanta on 10/03/25.
//
import Foundation

extension DateFormatter {
   
    static let ddMMyyyyTime: DateFormatter = {
        let formatter = DateFormatter()
//        formatter.dateFormat = "dd MMM yyyy HH:mm:ss"
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}


extension ISO8601DateFormatter {
    /// Standard ISO8601 formatter
    static let standard: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        // Simpler configuration, just the basic internet date/time format
        formatter.formatOptions = [.withInternetDateTime]
        
        return formatter
    }()
}
