//
//  Date+Extensions.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 31/08/23.
//

import SwiftUI

extension Date {
    
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
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> String {
        let moment = calendar.component(component, from: self)
        return moment >= 10 ? String(moment) : "0\(moment)"
    }
}
