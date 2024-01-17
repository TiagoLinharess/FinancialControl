//
//  BillViewModel.swift
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
    var incomes: [BillIncomeItemViewModel]
    var investments: [BillItemViewModel]
    var expenses: [BillItemViewModel]
    var creditCard: [BillItemViewModel]
    
    var balance: BillTotalItemViewModel {
        let balance = getTotalAt(items: incomes) - (getTotalAt(items: investments) + getTotalAt(items: expenses) + getTotalAt(items: creditCard))
        return .init(name: CoreConstants.Commons.total, value: balance)
    }
    
    // MARK: Init
    
    init(
        month: String,
        incomes: [BillIncomeItemViewModel] = [],
        investments: [BillItemViewModel] = [],
        expenses: [BillItemViewModel] = [],
        creditCard: [BillItemViewModel] = []
    ) {
        self.id = UUID().uuidString
        self.month = month
        self.incomes = incomes
        self.investments = investments
        self.expenses = expenses
        self.creditCard = creditCard
    }
    
    // MARK: Init from response
    
    init(from response: MonthlyBillsResponse) {
        self.id = response.id
        self.month = response.month
        self.incomes = [.init(id: UUID().uuidString, name: "Salario", value: 6400, status: .payed)]
        self.investments = [.init(id: UUID().uuidString, name: "previdencia", value: 300, status: .pending, installment: nil)]
        self.expenses = [.init(id: UUID().uuidString, name: "luz", value: 590, status: .payed, installment: nil)]
        self.creditCard = [.init(id: UUID().uuidString, name: "Dunk", value: 90, status: .pending, installment: .init(current: 3, max: 12))]
        // todo all init
    }
    
    // MARK: Methods
    
    func percentageOfRevenue(value: Double) -> Double {
        if getTotalAt(items: incomes) == .zero {
            return 100
        }
        
        return (value / getTotalAt(items: incomes)) * 100
    }
    
    func getResponse() -> MonthlyBillsResponse {
        return .init(
            id: id,
            month: month,
            income: nil,
            investment: nil,
            expense: nil
        )
    }
    
    func sectionTitle(at section: Int) -> String {
        switch section {
        case 0: return String(
            format: CoreConstants.Commons.divider,
            CoreConstants.Commons.incomesKey,
            formatTotal(value: getTotalAt(items: incomes).toCurrency())
        )
        case 1: return String(
            format: CoreConstants.Commons.divider,
            CoreConstants.Commons.investmentsKey,
            formatTotal(value: getTotalAt(items: investments).toCurrency())
        )
        case 2: return String(
            format: CoreConstants.Commons.divider,
            CoreConstants.Commons.expensesKey,
            formatTotal(value: getTotalAt(items: expenses).toCurrency())
        )
        case 3: return String(
            format: CoreConstants.Commons.divider,
            CoreConstants.Commons.creditCardKey,
            formatTotal(value: getTotalAt(items: creditCard).toCurrency())
        )
        default: return Constants.BillDetailView.balanceKey
        }
    }
    
    func numberOfRowsInSection(at section: Int) -> Int {
        switch getBillType(at: section) {
        case .income: return incomes.count
        case .investment: return investments.count
        case .expense: return expenses.count
        case .creditCard: return creditCard.count
        case nil: return 1
        }
    }
    
    func getItem(at indexPath: IndexPath) -> BillItemProtocol {
        switch getBillType(at: indexPath.section) {
        case .income: return incomes[indexPath.row]
        case .investment: return investments[indexPath.row]
        case .expense: return expenses[indexPath.row]
        case .creditCard: return creditCard[indexPath.row]
        case nil: return balance
        }
    }
    
    func getTotalAt(items: [BillItemProtocol]) -> Double {
        var total: Double = .zero
        
        items.forEach { item in
            total += item.value
        }
        
        return total
    }
    
    func getBillType(at section: Int) -> BillType? {
        return BillType(rawValue: section)
    }
    
    func formatTotal(value: String) -> String {
        return String(format: CoreConstants.Commons.spaceCompletion, CoreConstants.Commons.total, value)
    }
}
