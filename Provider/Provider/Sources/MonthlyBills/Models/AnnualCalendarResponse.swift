//
//  AnnualCalendarResponse.swift
//  Provider
//
//  Created by Tiago Linhares on 30/11/23.
//

import Foundation

public struct AnnualCalendarResponse: Codable {
    
    // MARK: Properties
    
    public let year: String
    public let monthlyBills: [MonthlyBillsResponse]
    
    // MARK: Init
    
    public init(year: String, monthlyBills: [MonthlyBillsResponse]) {
        self.year = year
        self.monthlyBills = monthlyBills
    }
}
