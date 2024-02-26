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
        return payedBalance + pendingBalance
    }
    
    var payedBalance: Double {
        let incomesTotal = getSection(at: .income)?.totalPayed ?? .zero
        return incomesTotal - total(for: .payed)
    }
    
    var pendingBalance: Double {
        let incomesTotal = getSection(at: .income)?.totalPending ?? .zero
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
    
    func total(for status: BillStatus) -> Double {
        return sections
            .filter { $0.type != .income }
            .reduce(0) {
                if status == .payed {
                    return $0 + $1.totalPayed
                }
                
                return $0 + $1.totalPending
            }
    }
}
