//
//  AnnualBillsViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 26/11/23.
//

import Foundation
import SharpnezCore

class AnnualBillsViewModel {
    
    // MARK: - Properties
    
    let year: String
    private(set) var monthlyBills: [MonthlyBillViewModel]
    
    // MARK: - Init
    
    init(year: String) {
        self.year = year
        self.monthlyBills = Calendar.current.monthSymbols.map { month -> MonthlyBillViewModel in
            return .init(month: month)
        }
    }
    
    // MARK: - Methods
    
    func set(bill: MonthlyBillViewModel, at index: Int) throws {
        if index > 11 || index < 0 {
            throw CoreError.customError("index out of bounds")
        }
        
        monthlyBills[index] = bill
    }
}
