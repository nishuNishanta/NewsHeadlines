//
//  Date+extension.swift
//  Headlines
//
//  Created by Nishu Nishanta on 10/03/25.
//
import Foundation

//used to convert date to desired string on how to show on UI
extension Date {
    var formattedDDMMYYY: String {
        let formattedDate = DateFormatter.ddMMyyyyTime
        return formattedDate.string(from: self)
    }
    
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
}

