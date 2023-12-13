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
    
    let id: String
    var shares: Double
    var privatePension: Double
    var fixedIncome: Double
    var other: Double
    
    var total: Double {
        shares + fixedIncome + privatePension + other
    }
    
    // MARK: Init from response
    
    init?(from response: InvestmentResponse?) {
        guard let response else { return nil }
        self.id = response.id
        self.shares = response.shares
        self.privatePension = response.privatePension
        self.fixedIncome = response.fixedIncome
        self.other = response.other
    }
    
    // MARK: Methods
    
    func getResponse() -> InvestmentResponse {
        return .init(
            id: id,
            shares: shares,
            privatePension: privatePension,
            fixedIncome: fixedIncome,
            other: other
        )
    }
}