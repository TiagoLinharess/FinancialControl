//
//  
//  InvestmentFormInteractor.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 04/01/24.
//
//

import Foundation
import SharpnezDesignSystem

protocol InvestmentFormInteracting { 
    func fetchInvestment(from billId: String)
    func submit(notes: String, investmentViewModel: InvestmentViewModel, billId: String)
}

final class InvestmentFormInteractor: UIVIPInteractor<InvestmentFormPresenting>, InvestmentFormInteracting {
    
    // MARK: Properties
    
    private let worker: BillsWorking
    
    // MARK: Init
    
    init(presenter: InvestmentFormPresenting, worker: BillsWorking = BillsWorker()) {
        self.worker = worker
        super.init(presenter: presenter)
    }
    
    // MARK: Methods
    
    func fetchInvestment(from billId: String) {
        do {
            let monthlyBillsViewModel = try worker.readAtMonth(id: billId)
            let notes = try worker.readNotes(at: .investments)
            presenter.presentSuccess(notes: notes, monthlyBillsViewModel: monthlyBillsViewModel)
        } catch {
            presenter.presentError(error: error)
        }
    }
    
    func submit(notes: String, investmentViewModel: InvestmentViewModel, billId: String) {
        do {
            try worker.updateInvestment(investmentViewModel: investmentViewModel, billId: billId)
            try worker.updateNotes(notes: notes, for: .investments)
            presenter.finishEdit()
        } catch {
            presenter.presentError(error: error)
        }
    }
}
