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
    func fetchIncome(from monthId: String)
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
    
    func fetchIncome(from monthId: String) {
        do {
            let monthlyBillsViewModel = try worker.readAtMonth(id: monthId)
            presenter.presentSuccess(monthlyBillsViewModel: monthlyBillsViewModel)
        } catch {
            presenter.presentError(error: error)
        }
    }
}
