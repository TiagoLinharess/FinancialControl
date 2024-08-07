//
//  ItemsRepository.swift
//  Provider
//
//  Created by Tiago Linhares on 11/03/24.
//

import CoreData
import Foundation
import SharpnezCore

protocol ItemsRepositoryProtocol {
    func create(item: BillItemResponse, billId: String, billSectionEntity: BillSectionEntity) throws
    func read(from billSectionEntity: BillSectionEntity) throws -> [BillItemEntity]
    func readAt(id: String) throws -> BillItemEntity?
    func update(item: BillItemResponse) throws
    func delete(id: String) throws
}

final class ItemsRepository: ItemsRepositoryProtocol {
    
    // MARK: Properties
    
    private let container: ProviderContainer = ProviderContainer.shared
    
    // MARK: Create
    
    func create(item: BillItemResponse, billId: String, billSectionEntity: BillSectionEntity) throws {
        if try readAt(id: item.id) != nil {
            throw CoreError.customError(Constants.MonthlyBillsRepository.existentItem)
        }
        
        let billItemEntity = BillItemEntity(context: container.persistentContainer.viewContext)
        billItemEntity.id = item.id
        billItemEntity.name = item.name
        billItemEntity.value = item.value
        billItemEntity.status = item.status.rawValue
        billSectionEntity.addToItems(billItemEntity)
        
        container.saveContext()
    }
    
    // MARK: Read
    
    func read(from billSectionEntity: BillSectionEntity) throws -> [BillItemEntity] {
        let billItemRequest: NSFetchRequest<BillItemEntity> = BillItemEntity.fetchRequest()
        billItemRequest.predicate = NSPredicate(format: "section = %@", billSectionEntity)
        
        return try container.persistentContainer.viewContext.fetch(billItemRequest)
    }
    
    func readAt(id: String) throws -> BillItemEntity? {
        let billItemRequest: NSFetchRequest<BillItemEntity> = BillItemEntity.fetchRequest()
        billItemRequest.predicate = NSPredicate(format: "id = %@", id)
        
        return try container.persistentContainer.viewContext.fetch(billItemRequest).first
    }
    
    // MARK: Update
    
    func update(item: BillItemResponse) throws {
        let billItemRequest: NSFetchRequest<BillItemEntity> = BillItemEntity.fetchRequest()
        billItemRequest.predicate = NSPredicate(format: "id = %@", item.id)
        
        guard let itemEntity = try container.persistentContainer.viewContext.fetch(billItemRequest).first else {
            throw CoreError.customError(Constants.MonthlyBillsRepository.itemNotFound)
        }
        
        itemEntity.setValue(item.name, forKey: "name")
        itemEntity.setValue(item.value, forKey: "value")
        itemEntity.setValue(item.status.rawValue, forKey: "status")
        
        container.saveContext()
    }
    
    // MARK: Delete
    
    func delete(id: String) throws {
        let billItemRequest: NSFetchRequest<BillItemEntity> = BillItemEntity.fetchRequest()
        billItemRequest.predicate = NSPredicate(format: "id = %@", id)
        
        guard let itemEntity = try container.persistentContainer.viewContext.fetch(billItemRequest).first else {
            throw CoreError.customError(Constants.MonthlyBillsRepository.itemNotFound)
        }
        
        container.persistentContainer.viewContext.delete(itemEntity)
        container.saveContext()
    }
}
