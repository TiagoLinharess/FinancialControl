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
    func configure(formType: BillItemFormType)
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
    
    func configure(formType: BillItemFormType) {
        switch formType {
        case .new, .template:
            break
        case let .edit(billId, itemId, billType):
            fetchItem(billId: billId, itemId: itemId, sectionType: billType)
        case let .templateEdit(itemId, billType):
            fetchTemplate(id: itemId, sectionType: billType)
        }
        fetchBillTypes()
    }
    
    func submit(viewModel: BillItemFormViewModel) {
        guard let formType = viewModel.formType else { return }
        
        do {
            switch formType {
            case let .new(billId):
                try submitItem(viewModel: viewModel, billId: billId)
            case let .edit(billId, itemId, _):
                try submitItem(viewModel: viewModel, billId: billId, currentItemId: itemId)
            case .template:
                try submitTemplate(viewModel: viewModel)
            case let .templateEdit(itemId, _):
                try submitTemplate(viewModel: viewModel, currentItemId: itemId)
            }
        } catch {
            presenter.presentError(error: error)
        }
    }
}

private extension BillItemFormInteractor {
    
    // MARK: Configure Methods
    
    func fetchItem(billId: String, itemId: String, sectionType: BillTypeViewModel) {
        do {
            let bill = try worker.readAtMonth(id: billId)
            presenter.presentItem(bill: bill, itemId: itemId, sectionType: sectionType)
        } catch {
            presenter.presentError(error: error)
        }
    }
    
    func fetchTemplate(id: String, sectionType: BillTypeViewModel) {
        do {
            let item = try worker.readTemplateAt(id: id)
            presenter.presentTemplate(templateItem: item, sectionType: sectionType)
        } catch {
            presenter.presentError(error: error)
        }
    }
    
    func fetchBillTypes() {
        do {
            let billTypes = try worker.readBillTypes()
            presenter.presentBillTypes(billTypesViewModel: billTypes)
        } catch {
            presenter.presentError(error: error)
        }
    }
}
private extension BillItemFormInteractor {
    
    // MARK: Submit Methods
    
    func submitItem(viewModel: BillItemFormViewModel, billId: String, currentItemId: String? = nil) throws {
        let itemId = currentItemId ?? UUID().uuidString
        var item: BillItemProtocol
        guard let billType = viewModel.billType,
              let status = viewModel.status,
              let name = viewModel.name,
              let value = viewModel.value
        else {
            throw CoreError.customError(Constants.BillItemFormView.fieldsError)
        }
        
        let installment = viewModel.validateInstallment ? viewModel.installment : nil
        
        if viewModel.validateInstallment && installment == nil {
            throw CoreError.customError(Constants.BillItemFormView.fieldsError)
        }
        
        if let installment = installment, viewModel.validateInstallment, !installment.isValid() {
            throw CoreError.customError(Constants.BillItemFormView.installmentError)
        }
        
        item = BillItemViewModel(id: itemId, name: name, value: value, status: status, installment: installment)
        
        if currentItemId != nil {
            try worker.updateBillItem(item: item, billId: billId)
        } else {
            try worker.createBillItem(item: item, billId: billId, billType: billType)
        }
        presenter.presentSuccess()
    }
    
    func submitTemplate(viewModel: BillItemFormViewModel, currentItemId: String? = nil) throws {
        let itemId = currentItemId ?? UUID().uuidString
        let value = viewModel.value ?? .zero
        var item: BillItemProtocol
        
        guard let billType = viewModel.billType,
              let name = viewModel.name
        else {
            throw CoreError.customError(Constants.BillItemFormView.fieldsError)
        }
        
        if viewModel.validateTemplateValue && viewModel.value == nil {
            throw CoreError.customError(Constants.BillItemFormView.fieldsError)
        }
        
        let installment = viewModel.validateInstallment ? viewModel.installment : nil
        
        if viewModel.validateInstallment && installment == nil {
            throw CoreError.customError(Constants.BillItemFormView.fieldsError)
        }
        
        if let installment = installment, viewModel.validateInstallment, !installment.isValid() {
            throw CoreError.customError(Constants.BillItemFormView.installmentError)
        }
        
        item = BillItemViewModel(id: itemId, name: name, value: value, status: .pending, installment: installment)
        
        if currentItemId != nil {
            try worker.updateTemplateItem(item: item)
        } else {
            try worker.createTemplateItem(item: item, billType: billType)
        }
        presenter.presentSuccess()
    }
}
