//
//  
//  IncomeFormInteractor.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 12/12/23.
//
//

import Foundation
import SharpnezDesignSystem

protocol IncomeFormInteracting { 
    func fetchIncome(from billId: String)
    func submit(incomeViewModel: IncomeViewModel, billId: String)
}

final class IncomeFormInteractor: UIVIPInteractor<IncomeFormPresenting>, IncomeFormInteracting {
    
    // MARK: Properties
    
    private let worker: BillsWorking
    
    // MARK: Init
    
    init(presenter: IncomeFormPresenting, worker: BillsWorking = BillsWorker()) {
        self.worker = worker
        super.init(presenter: presenter)
    }
    
    // MARK: Methods
    
    func fetchIncome(from billId: String) {
        do {
            let monthlyBillsViewModel = try worker.readAtMonth(id: billId)
            presenter.presentSuccess(monthlyBillsViewModel: monthlyBillsViewModel)
        } catch {
            presenter.presentError(error: error)
        }
    }
    
    func submit(incomeViewModel: IncomeViewModel, billId: String) {
        do {
            try worker.updateIncome(incomeViewModel: incomeViewModel, billId: billId)
            presenter.finishEdit()
        } catch {
            presenter.presentError(error: error)
        }
    }
}
