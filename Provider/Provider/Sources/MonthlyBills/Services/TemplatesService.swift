//
//  TemplatesService.swift
//  Provider
//
//  Created by Tiago Linhares on 14/03/24.
//

import CoreData
import Foundation
import SharpnezCore

protocol TemplatesServiceProtocol {
    func create(item: BillItemResponse, billType: BillTypeResponse) throws
    func read() throws -> [BillSectionResponse]
    func readAt(id: String) throws -> BillItemResponse
    func update(item: BillItemResponse) throws
    func delete(itemId: String) throws
}

final class TemplatesService: TemplatesServiceProtocol {
    
    // MARK: Properties
    
    private let templatesRepository: TemplatesRepositoryProtocol
    private let billTypeRepository: BillTypeRepositoryProtocol
    
    // MARK: Init
    
    init(
        templatesRepository: TemplatesRepositoryProtocol = TemplatesRepository(),
        billTypeRepository: BillTypeRepositoryProtocol = BillTypeRepository()
    ) {
        self.templatesRepository = templatesRepository
        self.billTypeRepository = billTypeRepository
    }
    
    // MARK: Create
    
    func create(item: BillItemResponse, billType: BillTypeResponse) throws {
        var templates = try read()
        
        if let sectionIndex = templates.firstIndex(where: { $0.type.name == billType.name }) {
            templates[sectionIndex].items.append(item)
        } else {
            templates.append(BillSectionResponse(items: [item], type: billType))
        }
        
        try templatesRepository.create(templates: templates)
    }
    
    // MARK: Read
    
    func read() throws -> [BillSectionResponse] {
        let billTypes = try billTypeRepository.read()
        let a = try templatesRepository.read().sorted { item1, item2 in
            let order1 = billTypes.firstIndex(where: { type in type.name == item1.type.name }) ?? .zero
            let order2 = billTypes.firstIndex(where: { type in type.name == item2.type.name }) ?? .zero
            return order1 < order2
        }
        return a
    }
    
    func readAt(id: String) throws -> BillItemResponse {
        let templates = try read()
        
        for template in templates {
            if let bill = template.items.first(where: { $0.id == id }) {
                return bill
            }
        }
        
        throw CoreError.customError(Constants.MonthlyBillsRepository.templateNotFound)
    }
    
    // MARK: Update
    
    func update(item: BillItemResponse) throws {
        var templates = try templatesRepository.read()
        let (templateIndex, itemIndex) = try findTemplateAndItemIndices(itemId: item.id)
        
        templates[templateIndex].items[itemIndex] = item
        try templatesRepository.create(templates: templates)
    }
    
    // MARK: Delete
    
    func delete(itemId: String) throws {
        var templates = try templatesRepository.read()
        let (templateIndex, itemIndex) = try findTemplateAndItemIndices(itemId: itemId)
        
        if templates[templateIndex].items.count == 1 {
            templates.remove(at: templateIndex)
        } else {
            templates[templateIndex].items.remove(at: itemIndex)
        }
        
        try templatesRepository.create(templates: templates)
    }
}

private extension TemplatesService {
    
    // MARK: Private Methods
    
    func findTemplateAndItemIndices(itemId: String) throws -> (sectionIndex: Int, itemIndex: Int) {
        let templates = try templatesRepository.read()
        
        for (templateIndex, template) in templates.enumerated() {
            if let itemIndex = template.items.firstIndex(where: { $0.id == itemId }) {
                return (templateIndex, itemIndex)
            }
        }
        
        throw CoreError.customError(Constants.MonthlyBillsRepository.itemNotFound)
    }
}
