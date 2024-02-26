//
//  
//  BillDetailInteractor.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 05/12/23.
//
//

import Foundation
import SharpnezDesignSystem

protocol BillDetailInteracting { 
    func fetch(with id: String)
    func fetchTemplates(billId: String)
    func delete(itemId: String, billId: String)
}

final class BillDetailInteractor: UIVIPInteractor<BillDetailPresenting>, BillDetailInteracting {
    
    // MARK: Properties
    
    private let worker: BillsWorking
    
    // MARK: Init
    
    init(presenter: BillDetailPresenting, worker: BillsWorking = BillsWorker()) {
        self.worker = worker
        super.init(presenter: presenter)
    }
    
    // MARK: Methods
    
    func fetch(with id: String) {
        do {
            let updatedBill = try worker.readAtMonth(id: id)
            presenter.presentSuccess(newBill: updatedBill)
        } catch {
            presenter.presentError(error: error)
        }
    }
    
    func fetchTemplates(billId: String) {
        do {
            let updatedBill = try worker.readAtMonthWithTemplates(billId: billId)
            presenter.presentSuccess(newBill: updatedBill)
        } catch {
            presenter.presentError(error: error)
        }
    }
    
    func delete(itemId: String, billId: String) {
        do {
            try worker.deleteItem(itemId: itemId, billId: billId)
            fetch(with: billId)
        } catch {
            presenter.presentError(error: error)
        }
    }
}
