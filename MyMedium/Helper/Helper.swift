//
//  Helper.swift
//  MyMedium
//
//  Created by neosoft on 11/01/23.
//

import Foundation
import SwiftUI

struct Helpers {
    static func isVaildEmailRegx(text:String) -> Bool {
        var isValidEmail = false
        let result = text.range(
            of: AppConst.emailPattern,
            options: .regularExpression
        )
        isValidEmail = (result != nil)
        return isValidEmail
    }
    
    static func isValidPassword(text:String) -> Bool {
        var isValidPassword = false
        
        if text.count >= 6 {
            isValidPassword = true
        } else {
            isValidPassword = false
        }
        return isValidPassword
    }
    
    static func isTheOwner (user: User?, author: Author?) -> Bool {
        if (user?.username != author?.username) {
            return false
        }
        return true
    }
    
    static func formatDateFormat (dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: dateString) {
           return date.timeAgoSinceNow
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
//            let formattedDate = dateFormatter.string(from: date)
//            return formattedDate
        } else {
            return "Invalid Date"
        }
    }
}

extension Date {
    var timeAgoSinceNow: String {
        let calendar = Calendar.current
        let now = Date()
        let unitFlags: Set<Calendar.Component> = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = calendar.dateComponents(unitFlags, from: self, to: now)
        
        if let year = components.year, year >= 2 {
            return "\(year) years ago"
        } else if let year = components.year, year >= 1 {
            return "Last year"
        } else if let month = components.month, month >= 2 {
            return "\(month) months ago"
        } else if let month = components.month, month >= 1 {
            return "Last month"
        } else if let week = components.weekOfYear, week >= 2 {
            return "\(week) weeks ago"
        } else if let week = components.weekOfYear, week >= 1 {
            return "Last week"
        } else if let day = components.day, day >= 2 {
            return "\(day) days ago"
        } else if let day = components.day, day >= 1 {
            return "Yesterday"
        } else if let hour = components.hour, hour >= 2 {
            return "\(hour) hours ago"
        } else if let hour = components.hour, hour >= 1 {
            return "An hour ago"
        } else if let minute = components.minute, minute >= 2 {
            return "\(minute) minutes ago"
        } else if let minute = components.minute, minute >= 1 {
            return "A minute ago"
        } else if let second = components.second, second >= 3 {
            return "\(second) seconds ago"
        } else {
            return "Just now"
        }
    }
}

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
