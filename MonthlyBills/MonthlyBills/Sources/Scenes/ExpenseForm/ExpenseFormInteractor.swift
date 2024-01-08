//
//  
//  ExpenseFormInteractor.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 06/01/24.
//
//

import Foundation
import SharpnezDesignSystem

protocol ExpenseFormInteracting {
    func fetchInvestment(from billId: String)
    func submit(notes: String, expenseViewModel: ExpenseViewModel, billId: String)
}

final class ExpenseFormInteractor: UIVIPInteractor<ExpenseFormPresenting>, ExpenseFormInteracting {
    
    // MARK: Properties
    
    private let worker: BillsWorking
    
    // MARK: Init
    
    init(presenter: ExpenseFormPresenting, worker: BillsWorking = BillsWorker()) {
        self.worker = worker
        super.init(presenter: presenter)
    }
    
    // MARK: Methods
    
    func fetchInvestment(from billId: String) {
        do {
            let monthlyBillsViewModel = try worker.readAtMonth(id: billId)
            let notes = try worker.readNotes(at: .expenses)
            presenter.presentSuccess(notes: notes, monthlyBillsViewModel: monthlyBillsViewModel)
        } catch {
            presenter.presentError(error: error)
        }
    }
    
    func submit(notes: String, expenseViewModel: ExpenseViewModel, billId: String) {
        do {
            try worker.updateExpense(expenseViewModel: expenseViewModel, billId: billId)
            try worker.updateNotes(notes: notes, for: .expenses)
            presenter.finishEdit()
        } catch {
            presenter.presentError(error: error)
        }
    }
}
