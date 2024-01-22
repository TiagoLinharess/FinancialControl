//
//  MonthlyBillsViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 26/11/23.
//

import Core
import Foundation
import Provider

struct MonthlyBillsViewModel {
    
    // MARK: Properties
    
    let id: String
    let month: String
    let sections: [BillSectionViewModel]
    
    var balance: Double {
        let incomesTotal = getSection(at: .income)?.total ?? .zero
        var expenses: Double = .zero
        
        sections.forEach { section in
            if section.type != .income {
                expenses += section.total
            }
        }
        
        return incomesTotal - expenses
    }
    
    // MARK: Init
    
    init(
        month: String,
        sections: [BillSectionViewModel] = []
    ) {
        self.id = UUID().uuidString
        self.month = month
        self.sections = sections
    }
    
    // MARK: Init from response
    
    init(from response: MonthlyBillsResponse) {
        self.id = response.id
        self.month = response.month
        self.sections = []
        // todo implement service after form
    }
    
    // MARK: Methods
    
    func getResponse() -> MonthlyBillsResponse {
        return .init(
            id: id,
            month: month,
            income: nil,
            investment: nil,
            expense: nil
        )
    }
    
    func sectionFooter(at section: Int) -> String? {
        let section = sections[section]
        let incomesTotal = getSection(at: .income)?.total ?? .zero
        
        if section.type == .income {
            return nil
        }
        
        if incomesTotal == .zero {
            return Constants.BillDetailView.zeroIncomePercentage
        }
        
        let percentage = (section.total / incomesTotal) * 100
        return String(format: CoreConstants.Commons.percentageIcon, String(percentage))
    }
}

private extension MonthlyBillsViewModel {
    
    // MARK: Private Methods
    
    func getSection(at billType: BillType) -> BillSectionViewModel? {
        return sections.first { section in
            section.type == billType
        }
    }
}
