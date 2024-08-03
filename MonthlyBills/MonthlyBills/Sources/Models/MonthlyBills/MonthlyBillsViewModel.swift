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
    
    var creditTotal: Double {
        var creditTotal: Double = .zero
        
        let sections = sections.filter { section in
            section.type.name.lowercased().contains("creditcard")
        }
        
        sections.forEach { viewModel in
            if !viewModel.title.lowercased().contains("creditcard loan") {
                creditTotal += viewModel.total
            }
        }
        
        return creditTotal
    }
    
    var balance: Double {
        return payedBalance + pendingBalance
    }
    
    var payedBalance: Double {
        let incomesTotal = getIncomes(for: .payed) ?? .zero
        return incomesTotal - total(for: .payed)
    }
    
    var pendingBalance: Double {
        let incomesTotal = getIncomes(for: .pending) ?? .zero
        return incomesTotal - total(for: .pending)
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
    
    // MARK: Init From Response
    
    init(from response: MonthlyBillsResponse) {
        self.id = response.id
        self.month = response.month
        self.sections = response.sections.map({ response -> BillSectionViewModel in
            return .init(from: response)
        })
    }
    
    // MARK: Methods
    
    func getResponse() -> MonthlyBillsResponse {
        return .init(
            id: id,
            month: month,
            sections: sections.map({ viewModel -> BillSectionResponse in
                return viewModel.getResponse()
            })
        )
    }
    
    func sectionFooter(at section: Int) -> String? {
        let section = sections[section]
        let incomesTotal = getIncomes(for: nil) ?? .zero
        
        if section.type.isIncome {
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
    
    func getIncomes(for status: BillStatus?) -> Double? {
        return sections
            .filter { $0.type.isIncome }
            .reduce(0) {
                
                if status == nil {
                    return $0 + $1.total
                }
                
                if status == .payed {
                    return $0 + $1.totalPayed
                }
            
                return $0 + $1.totalPending
            }
    }
    
    func total(for status: BillStatus) -> Double {
        return sections
            .filter { !$0.type.isIncome }
            .reduce(0) {
                if status == .payed {
                    return $0 + $1.totalPayed
                }
                
                return $0 + $1.totalPending
            }
    }
}
