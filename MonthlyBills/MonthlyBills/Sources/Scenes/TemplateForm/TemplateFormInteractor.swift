//
//  
//  TemplateFormInteractor.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 02/02/24.
//
//

import Foundation
import SharpnezDesignSystem

protocol TemplateFormInteracting { 
    func fetch()
    func delete(at id: String)
}

final class TemplateFormInteractor: UIVIPInteractor<TemplateFormPresenting>, TemplateFormInteracting {
    
    // MARK: Properties
    
    private let worker: BillsWorking
    
    // MARK: Init
    
    init(presenter: TemplateFormPresenting, worker: BillsWorking = BillsWorker()) {
        self.worker = worker
        super.init(presenter: presenter)
    }
    
    // MARK: Methods
    
    func fetch() {
        do {
            let templates = try worker.readTemplates()
            presenter.presentSuccess(templates: templates)
        } catch {
            presenter.presentError(error: error)
        }
    }
    
    func delete(at id: String) {
        do {
            try worker.deleteTemplateItem(itemId: id)
            fetch()
        } catch {
            presenter.presentError(error: error)
        }
    }
}
