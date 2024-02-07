//
//  Date+Ext.swift
//  Unsplash
//
//  Created by Ion Belous on 16.10.2023.
//

import Foundation

extension Date {
    
    func daysAgoString() -> String {
        let days = Calendar.current.dateComponents(
            [.day],
            from: self,
            to: Date()
        ).day ?? 0
        
        var dateString = ""
        
        switch days {
        case 0: dateString = "today"
        case 1: dateString = "\(days) day ago"
        case 1...: dateString = "\(days) days ago"
        default: break
        }
        
        return dateString
    }
}
