//
//  InvestmentViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 27/11/23.
//

import Foundation
import Provider

struct InvestmentViewModel {
    
    // MARK: Properties
    
    var shares: Double
    var privatePension: Double
    var fixedIncome: Double
    var other: Double
    
    var total: Double {
        shares + fixedIncome + privatePension + other
    }
    
    // MARK: Init
    
    init(shares: Double, privatePension: Double, fixedIncome: Double, other: Double) {
        self.shares = shares
        self.privatePension = privatePension
        self.fixedIncome = fixedIncome
        self.other = other
    }
    
    // MARK: Init from response
    
    init?(from response: InvestmentResponse?) {
        guard let response else { return nil }
        self.shares = response.shares
        self.privatePension = response.privatePension
        self.fixedIncome = response.fixedIncome
        self.other = response.other
    }
    
    // MARK: Methods
    
    func getResponse() -> InvestmentResponse {
        return .init(
            shares: shares,
            privatePension: privatePension,
            fixedIncome: fixedIncome,
            other: other
        )
    }
}
