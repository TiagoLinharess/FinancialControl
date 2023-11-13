//
//  Date+Extensions.swift
//  Core
//
//  Created by Tiago Linhares on 13/11/23.
//

import Foundation

public extension Date {
    
    // MARK: Locale Format
    
    var localeFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale.current
        
        return dateFormatter.string(from: self)
    }
}
