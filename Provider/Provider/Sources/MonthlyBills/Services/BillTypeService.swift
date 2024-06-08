//
//  BillTypeService.swift
//  Provider
//
//  Created by Tiago Linhares on 08/06/24.
//

import Foundation
import SharpnezCore

protocol BillTypeServiceProtocol {
    func create(name: String) throws
    func read() throws -> [BillTypeResponse]
    func update(id: String) throws
    func updateOrder(billTypes: [BillTypeResponse]) throws
    func delete(id: String) throws
}

final class BillTypeService: BillTypeServiceProtocol {
    
    // MARK: Properties
    
    private let repository: BillTypeRepositoryProtocol
    
    // MARK: Init
    
    init(
        repository: BillTypeRepositoryProtocol = BillTypeRepository()
    ) {
        self.repository = repository
    }
    
    // MARK: Create
    
    func create(name: String) throws {
        var currentList = try read()
        
        if currentList.first(where: { $0.name == name }) != nil {
            throw CoreError.customError(Constants.MonthlyBillsRepository.existentItem)
        }
        
        let response = BillTypeResponse(
            id: UUID().uuidString,
            name: name,
            isIncome: false
        )
        
        currentList.append(response)
        
        try repository.create(items: currentList)
    }
    
    // MARK: Read
    
    func read() throws -> [BillTypeResponse] {
        var items = try repository.read()
        
        if items.isEmpty {
            items = try generateDefaultTypes()
        }
        
        return items
    }
    
    // MARK: Update
    
    func update(id: String) throws {
        var currentList = try read()
        
        if let index = currentList.firstIndex(where: { $0.id == id }) {
            currentList[index].isIncome.toggle()
            try repository.create(items: currentList)
        } else {
            throw CoreError.customError(Constants.MonthlyBillsRepository.itemNotFound)
        }
    }
    
    func updateOrder(billTypes: [BillTypeResponse]) throws {
        try repository.create(items: billTypes)
    }
    
    // MARK: Delete
    
    func delete(id: String) throws {
        var currentList = try read()
        
        if let index = currentList.firstIndex(where: { $0.id == id }) {
            currentList.remove(at: index)
            try repository.create(items: currentList)
        } else {
            throw CoreError.customError(Constants.MonthlyBillsRepository.itemNotFound)
        }
    }
}

private extension BillTypeService {
    
    // MARK: Methods
    
    func generateDefaultTypes() throws -> [BillTypeResponse] {
        let items: [BillTypeResponse] = [
            BillTypeResponse(
                id: UUID().uuidString,
                name: Constants.MonthlyBillsRepository.incomes,
                isIncome: true
            ),
            BillTypeResponse(
                id: UUID().uuidString,
                name: Constants.MonthlyBillsRepository.investment,
                isIncome: false
            ),
            BillTypeResponse(
                id: UUID().uuidString,
                name: Constants.MonthlyBillsRepository.expenses,
                isIncome: false
            ),BillTypeResponse(
                id: UUID().uuidString,
                name: Constants.MonthlyBillsRepository.creditCard,
                isIncome: false
            )
        ]
        
        try repository.create(items: items)
        return items
    }
}
