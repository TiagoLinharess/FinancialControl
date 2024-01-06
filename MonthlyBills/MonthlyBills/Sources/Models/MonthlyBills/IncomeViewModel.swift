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
    
    var salary: Double
    var bonus: Double
    var extra: Double
    var other: Double
    
    var total: Double {
        salary + bonus + extra + other
    }
    
    // MARK: Init
    
    init(salary: Double, bonus: Double, extra: Double, other: Double) {
        self.salary = salary
        self.bonus = bonus
        self.extra = extra
        self.other = other
    }
    
    // MARK: Init from response
    
    init?(from response: IncomeResponse?) {
        guard let response else { return nil }
        self.salary = response.salary
        self.bonus = response.bonus
        self.extra = response.extra
        self.other = response.other
    }
    
    // MARK: Methods
    
    func getResponse() -> IncomeResponse {
        return .init(
            salary: salary,
            bonus: bonus,
            extra: extra,
            other: other
        )
    }
}
