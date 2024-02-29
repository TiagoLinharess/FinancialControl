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
    public var monthlyBills: [MonthlyBillsResponse]
    
    // MARK: Init
    
    public init(year: String, monthlyBills: [MonthlyBillsResponse]) {
        self.year = year
        self.monthlyBills = monthlyBills
    }
    
    // MARK: Init From Entity
    
    init(from annualCalendarEntity: AnnualCalendarEntity, with monthlyBillsEntities: [MonthlyBillsEntity]) {
        self.year = annualCalendarEntity.year ?? String()
        self.monthlyBills = monthlyBillsEntities.map { monthlyBillsEntity -> MonthlyBillsResponse in
            return MonthlyBillsResponse(from: monthlyBillsEntity)
        }
    }
}
