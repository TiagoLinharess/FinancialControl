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
}

final class ItemsRepository: ItemsRepositoryProtocol {
    
    // MARK: Properties
    
    private let container: ProviderContainer = ProviderContainer.shared
    
    // MARK: Create
    
    func create(item: BillItemResponse, billId: String, billSectionEntity: BillSectionEntity) throws {
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
}
