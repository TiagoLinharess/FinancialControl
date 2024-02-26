//
//  AnnualCalendarViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 26/11/23.
//

import Core
import Foundation
import Provider
import SharpnezCore

class AnnualCalendarViewModel {
    
    // MARK: Properties
    
    let year: String
    private(set) var monthlyBills: [MonthlyBillsViewModel]
    
    // MARK: Init
    
    init(year: String) {
        self.year = year
        self.monthlyBills = Calendar.current.monthSymbols.map { month -> MonthlyBillsViewModel in
            return .init(month: month)
        }
    }
    
    // MARK: Init from response
    
    init(from response: AnnualCalendarResponse) {
        self.year = response.year
        self.monthlyBills = response.monthlyBills.map { .init(from: $0) }
    }
    
    // MARK: Methods
    
    func getResponse() -> AnnualCalendarResponse {
        return .init(year: year, monthlyBills: monthlyBills.map { $0.getResponse() })
    }
}
