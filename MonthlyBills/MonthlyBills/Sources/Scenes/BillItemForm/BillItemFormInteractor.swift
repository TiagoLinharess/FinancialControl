//
//  
//  BillItemFormInteractor.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 18/01/24.
//
//

import Foundation
import SharpnezDesignSystem

protocol BillItemFormInteracting { 
    func submit(viewModel: BillItemFormViewModel)
}

final class BillItemFormInteractor: UIVIPInteractor<BillItemFormPresenting>, BillItemFormInteracting {
    
    // MARK: Properties
    
    let worker: BillsWorking
    
    // MARK: Init
    
    init(presenter: BillItemFormPresenting, worker: BillsWorking = BillsWorker()) {
        self.worker = worker
        super.init(presenter: presenter)
    }
    
    // MARK: Methods
    
    func submit(viewModel: BillItemFormViewModel) {
        switch viewModel.formType {
        case let .new(billId):
            break
        case .edit( _, _, _):
            break
        case .template:
            break
        case .templateEdit:
            break
        case .none:
            break
        }
    }
}
