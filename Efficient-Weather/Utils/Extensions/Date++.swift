//
//  Date++.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/5/23.
//

import Foundation

extension Date {
    
    static func currentDate()-> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
    
    func toString(format: DateFormat) -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
    
    static func getUpcomingDay(addDay: Int) -> String? {
        let calendar = Calendar.current
        var dateComponent = DateComponents()
        dateComponent.day = addDay

        if let nextDate = calendar.date(byAdding: dateComponent, to: Date()) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: nextDate)
            print(dateString)
            return dateString
        } else {
            return nil
        }
    }
}
