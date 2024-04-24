//
//  SectionsRepository.swift
//  Provider
//
//  Created by Tiago Linhares on 12/03/24.
//

import CoreData
import Foundation
import SharpnezCore

protocol SectionsRepositoryProtocol {
    func read(from monthlyBillsEntity: MonthlyBillsEntity) throws -> [BillSectionEntity]
    func readAt(billType: BillSectionResponse.BillType, monthlyBillsEntity: MonthlyBillsEntity) throws -> BillSectionEntity?
    func createAndRead(billType: BillSectionResponse.BillType, monthlyBillsEntity: MonthlyBillsEntity) throws -> BillSectionEntity
}

final class SectionsRepository: SectionsRepositoryProtocol {
    
    // MARK: Properties
    
    private let container: ProviderContainer = ProviderContainer.shared
    
    // MARK: Read
    
    func read(from monthlyBillsEntity: MonthlyBillsEntity) throws -> [BillSectionEntity] {
        let billSectionRequest: NSFetchRequest<BillSectionEntity> = BillSectionEntity.fetchRequest()
        billSectionRequest.predicate = NSPredicate(format: "bill = %@", monthlyBillsEntity)
        
        return try container.persistentContainer.viewContext.fetch(billSectionRequest)
    }
    
    func readAt(billType: BillSectionResponse.BillType, monthlyBillsEntity: MonthlyBillsEntity) throws -> BillSectionEntity? {
        let billSectionRequest: NSFetchRequest<BillSectionEntity> = BillSectionEntity.fetchRequest()
        billSectionRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [
            NSPredicate(format: "type = %@", billType.rawValue),
            NSPredicate(format: "bill = %@", monthlyBillsEntity)
        ])
        
        return try container.persistentContainer.viewContext.fetch(billSectionRequest).first
    }
    
    // MARK: Create
    
    func createAndRead(billType: BillSectionResponse.BillType, monthlyBillsEntity: MonthlyBillsEntity) throws -> BillSectionEntity {
        let billSectionEntity = BillSectionEntity(context: container.persistentContainer.viewContext)
        billSectionEntity.id = UUID().uuidString
        billSectionEntity.type = billType.rawValue
        monthlyBillsEntity.addToSections(billSectionEntity)
        
        container.saveContext()
        return billSectionEntity
    }
}
