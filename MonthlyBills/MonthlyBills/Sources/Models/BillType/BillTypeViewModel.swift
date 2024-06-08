//
//  BillTypeViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 08/06/24.
//

import Foundation
import Provider

struct BillTypeViewModel {
    
    // MARK: Properties
    
    let id: String
    let name: String
    let isIncome: Bool
    
    // MARK: Init
    
    init(from response: BillTypeResponse) {
        self.id = response.id
        self.name = response.name
        self.isIncome = response.isIncome
    }
    
    // MARK: Methods
    
    func getResponse() -> BillTypeResponse {
        return BillTypeResponse(
            id: id,
            name: name,
            isIncome: isIncome
        )
    }
}
