//
//  InstallmentsRepository.swift
//  Provider
//
//  Created by Tiago Linhares on 15/03/24.
//

import CoreData
import Foundation
import SharpnezCore

protocol InstallmentsRepositoryProtocol {
    func create(installmentResponse: BillItemResponse.BillInstallment, billItemEntity: BillItemEntity) throws
    func read(from billItemEntity: BillItemEntity) throws -> InstallmentEntity?
    func update(installmentResponse: BillItemResponse.BillInstallment, billItemEntity: BillItemEntity) throws
    func delete(billItemEntity: BillItemEntity) throws
}

final class InstallmentsRepository: InstallmentsRepositoryProtocol {
    
    // MARK: Properties
    
    private let container: ProviderContainer = ProviderContainer.shared
    
    // MARK: Create
    
    func create(installmentResponse: BillItemResponse.BillInstallment, billItemEntity: BillItemEntity) throws {
        let installmentEntity = InstallmentEntity(context: container.persistentContainer.viewContext)
        installmentEntity.current = Int64(installmentResponse.current)
        installmentEntity.max = Int64(installmentResponse.max)
        billItemEntity.installment = installmentEntity
        
        container.saveContext()
    }
    
    // MARK: Read
    
    func read(from billItemEntity: BillItemEntity) throws -> InstallmentEntity? {
        let installmentRequest: NSFetchRequest<InstallmentEntity> = InstallmentEntity.fetchRequest()
        installmentRequest.predicate = NSPredicate(format: "bill = %@", billItemEntity)
        
        return try container.persistentContainer.viewContext.fetch(installmentRequest).first
    }
    
    // MARK: Update
    
    func update(installmentResponse: BillItemResponse.BillInstallment, billItemEntity: BillItemEntity) throws {
        let installmentRequest: NSFetchRequest<InstallmentEntity> = InstallmentEntity.fetchRequest()
        installmentRequest.predicate = NSPredicate(format: "bill = %@", billItemEntity)
        
        guard let installmentEntity = try container.persistentContainer.viewContext.fetch(installmentRequest).first else {
            throw CoreError.customError(Constants.MonthlyBillsRepository.itemNotFound)
        }
        
        installmentEntity.setValue(installmentResponse.current, forKey: "current")
        installmentEntity.setValue(installmentResponse.max, forKey: "max")
        
        container.saveContext()
    }
    
    // MARK: Delete
    
    func delete(billItemEntity: BillItemEntity) throws {
        let installmentRequest: NSFetchRequest<InstallmentEntity> = InstallmentEntity.fetchRequest()
        installmentRequest.predicate = NSPredicate(format: "bill = %@", billItemEntity)
        
        guard let installmentEntity = try container.persistentContainer.viewContext.fetch(installmentRequest).first else {
            throw CoreError.customError(Constants.MonthlyBillsRepository.itemNotFound)
        }
        
        container.persistentContainer.viewContext.delete(installmentEntity)
        container.saveContext()
    }
}
