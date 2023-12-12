//
//  IncomeViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 27/11/23.
//

import Foundation
import Provider

struct IncomeViewModel {
    
    // MARK: Properties
    
    let id: String
    var salary: Double
    var bonus: Double
    var extra: Double
    var other: Double
    
    var total: Double {
        salary + bonus + extra + other
    }
    
    // MARK: Init from response
    
    init?(from response: IncomeResponse?) {
        guard let response else { return nil }
        self.id = response.id
        self.salary = response.salary
        self.bonus = response.bonus
        self.extra = response.extra
        self.other = response.other
    }
    
    // MARK: Methods
    
    func getResponse() -> IncomeResponse {
        return .init(
            id: id,
            salary: salary,
            bonus: bonus,
            extra: extra,
            other: other
        )
    }
}
