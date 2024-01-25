//
//
//  BillItemFormInteractor.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 18/01/24.
//
//

import Foundation
import SharpnezCore
import SharpnezDesignSystem

protocol BillItemFormInteracting {
    func submit(viewModel: BillItemFormViewModel)
}

final class BillItemFormInteractor: UIVIPInteractor<BillItemFormPresenting>, BillItemFormInteracting {
    
    // MARK: Properties
    
    private let worker: BillsWorking
    
    // MARK: Init
    
    init(presenter: BillItemFormPresenting, worker: BillsWorking = BillsWorker()) {
        self.worker = worker
        super.init(presenter: presenter)
    }
    
    // MARK: Methods
    
    func submit(viewModel: BillItemFormViewModel) {
        guard let formType = viewModel.formType else { return }
        
        do {
            switch formType {
            case let .new(billId):
                try submitItem(viewModel: viewModel, billId: billId)
            case .edit( _, _, _):
                break
            case .template:
                break
            case .templateEdit:
                break
            }
        } catch {
            presenter.presentError(error: error)
        }
    }
}

private extension BillItemFormInteractor {
    
    // MARK: Submit Methods
    
    func submitItem(viewModel: BillItemFormViewModel, billId: String) throws {
        var item: BillItemProtocol
        guard let billType = viewModel.billType,
              let status = viewModel.status,
              let name = viewModel.name,
              let value = viewModel.value
        else {
            throw CoreError.customError(Constants.BillItemFormView.fieldsError)
        }
        
        if billType == .income {
            item = BillIncomeItemViewModel(name: name, value: value, status: status)
        } else {
            let installment = viewModel.validateInstallment ? viewModel.installment : nil
            
            if viewModel.validateInstallment && installment == nil {
                throw CoreError.customError(Constants.BillItemFormView.fieldsError)
            }
            
            if let installment = installment, viewModel.validateInstallment, !installment.isValid() {
                throw CoreError.customError(Constants.BillItemFormView.installmentError)
            }
            
            item = BillItemViewModel(name: name, value: value, status: status, installment: installment)
        }
        
        try worker.createBillItem(item: item, billId: billId, billType: billType)
        presenter.presentSuccess()
    }
}
