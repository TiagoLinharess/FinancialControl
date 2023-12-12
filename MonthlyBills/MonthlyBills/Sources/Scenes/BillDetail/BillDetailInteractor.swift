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
    func update(with id: String)
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
    
    func update(with id: String) {
        do {
            let updatedBill = try worker.readAtMonth(id: id)
            presenter.presentSuccess(newBill: updatedBill)
        } catch {
            presenter.presentError(error: error)
        }
    }
}
