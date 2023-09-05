//
//  Date+Extensions.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 31/08/23.
//

import SwiftUI

extension Date {
    
    // MARK: Locale Format
    
    var localeFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale.current
        
        return dateFormatter.string(from: self)
    }
    
    // MARK: First Week Day Of Month
    
    func firstWeekDayOfMonth(with weekday: Int) -> [Date] {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .weekdayOrdinal], from: self)
        var result = [Date]()
        
        components.weekday = weekday
        
        for ordinal in 1..<6 {
            components.weekdayOrdinal = ordinal
            
            guard let date = calendar.date(from: components),
                  let month = components.month
            else { break }
            
            if calendar.component(.month, from: date) != month { break }
            
            guard let date = calendar.date(from: components) else { break }
            
            result.append(date)
        }
        
        return result
    }
}
