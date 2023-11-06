//
//  String++.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/5/23.
//

import Foundation

enum DateFormat: String {
    case type1 = "yyyy-MM-dd HH:mm:ss" // 2022-06-15 15:58:55
    case type2 = "MMM dd, yyyy"
    case type3 = "yyyy-MM-dd"
    case type4 = "MMMM dd, yyyy"
    case type5 = "h:mm a"
    case type6 = "yyyy-MM-dd h:mm a"
    case type7 = "E"
}



extension String {
    
    func utcToLocalDateStr(originFormat: DateFormat, resultFormat: DateFormat) -> String? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = originFormat.rawValue
        if let date = formatter.date(from: self) {
            formatter.timeZone = .current
            formatter.dateFormat = resultFormat.rawValue
            return formatter.string(from: date)
        }
        return nil
    }
    
    func toDate(format: DateFormat) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        formatter.dateFormat = format.rawValue
        if let date = formatter.date(from: self) {
            debugPrint("date is \(date)")
            return date
        }
        return nil
    }
    
}
