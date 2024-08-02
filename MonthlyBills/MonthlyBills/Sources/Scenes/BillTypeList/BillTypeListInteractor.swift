//
//  
//  BillTypeListInteractor.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 08/06/24.
//
//

import Foundation
import SharpnezDesignSystem

protocol BillTypeListInteracting { 
    func fetch()
    func add(name: String)
    func toggle(id: String)
    func delete(with id: String)
    func organize(billTypes: [BillTypeViewModel])
}

final class BillTypeListInteractor: UIVIPInteractor<BillTypeListPresenting>, BillTypeListInteracting {
    
    // MARK: Properties
    
    private let worker: BillsWorking
    
    // MARK: Init
    
    init(presenter: BillTypeListPresenting, worker: BillsWorking = BillsWorker()) {
        self.worker = worker
        super.init(presenter: presenter)
    }
    
    // MARK: Methods
    
    func fetch() {
        do {
            let billTypes = try worker.readBillTypes()
            presenter.presentSuccess(billTypes: billTypes)
        } catch {
            presenter.presentError(error: error)
        }
    }
    
    func add(name: String) {
        do {
            try worker.createBillType(name: name)
            fetch()
        } catch {
            presenter.presentError(error: error)
        }
    }
    
    func toggle(id: String) {
        do {
            try worker.updateBillType(id: id)
        } catch {
            fetch()
            presenter.presentError(error: error)
        }
    }
    
    func delete(with id: String) {
        do {
            try worker.deleteBillType(id: id)
        } catch {
            fetch()
            presenter.presentError(error: error)
        }
    }
    
    func organize(billTypes: [BillTypeViewModel]) {
        do {
            try worker.updateBillTypesOrder(billTypes: billTypes)
        } catch {
            fetch()
            presenter.presentError(error: error)
        }
    }
}
