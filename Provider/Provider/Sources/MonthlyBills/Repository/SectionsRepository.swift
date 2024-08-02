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
    func readAt(billType: BillTypeResponse, monthlyBillsEntity: MonthlyBillsEntity) throws -> BillSectionEntity?
    func createAndRead(billType: BillTypeResponse, monthlyBillsEntity: MonthlyBillsEntity) throws -> BillSectionEntity
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
    
    func readAt(billType: BillTypeResponse, monthlyBillsEntity: MonthlyBillsEntity) throws -> BillSectionEntity? {
        let billSectionRequest: NSFetchRequest<BillSectionEntity> = BillSectionEntity.fetchRequest()
        billSectionRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [
            NSPredicate(format: "type = %@", billType.name),
            NSPredicate(format: "bill = %@", monthlyBillsEntity)
        ])
        
        return try container.persistentContainer.viewContext.fetch(billSectionRequest).first
    }
    
    // MARK: Create
    
    func createAndRead(billType: BillTypeResponse, monthlyBillsEntity: MonthlyBillsEntity) throws -> BillSectionEntity {
        let billSectionEntity = BillSectionEntity(context: container.persistentContainer.viewContext)
        billSectionEntity.id = UUID().uuidString
        billSectionEntity.type = billType.name
        billSectionEntity.isIncome = billType.isIncome
        monthlyBillsEntity.addToSections(billSectionEntity)
        
        container.saveContext()
        return billSectionEntity
    }
}
