//
//  BillsRepository.swift
//  Provider
//
//  Created by Tiago Linhares on 11/03/24.
//

import CoreData
import Foundation
import SharpnezCore

protocol BillsRepositoryProtocol {
    func createMonths(for annualCalendarEntity: AnnualCalendarEntity) throws
    func read(from annualCalendarEntity: AnnualCalendarEntity) throws -> [MonthlyBillsEntity]
    func readAtMonth(id: String) throws -> MonthlyBillsEntity
}

final class BillsRepository: BillsRepositoryProtocol {
    
    // MARK: Properties
    
    private let container: ProviderContainer = ProviderContainer.shared
    
    // MARK: Create
    
    func createMonths(for annualCalendarEntity: AnnualCalendarEntity) throws {
        Calendar.current.monthSymbols.forEach { month in
            let monthlyBillsEntity = MonthlyBillsEntity(context: container.persistentContainer.viewContext)
            monthlyBillsEntity.id = UUID().uuidString
            monthlyBillsEntity.month = month
            annualCalendarEntity.addToMonths(monthlyBillsEntity)
        }
        
        container.saveContext()
    }
    
    // MARK: Read
    
    func read(from annualCalendarEntity: AnnualCalendarEntity) throws -> [MonthlyBillsEntity] {
        let monthlyBillsRequest: NSFetchRequest<MonthlyBillsEntity> = MonthlyBillsEntity.fetchRequest()
        monthlyBillsRequest.predicate = NSPredicate(format: "year = %@", annualCalendarEntity)
        
        return try container.persistentContainer.viewContext.fetch(monthlyBillsRequest)
    }
    
    func readAtMonth(id: String) throws -> MonthlyBillsEntity {
        let monthlyBillsRequest: NSFetchRequest<MonthlyBillsEntity> = MonthlyBillsEntity.fetchRequest()
        monthlyBillsRequest.predicate = NSPredicate(format: "id = %@", id)
        
        guard let monthlyBillsEntity = try container.persistentContainer.viewContext.fetch(monthlyBillsRequest).first else {
            throw CoreError.customError(Constants.MonthlyBillsRepository.billNotFound)
        }
        
        return monthlyBillsEntity
    }
}
