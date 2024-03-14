//
//  CalendarsRepository.swift
//  Provider
//
//  Created by Tiago Linhares on 29/02/24.
//

import CoreData
import Foundation
import SharpnezCore

protocol CalendarsRepositoryProtocol {
    func create(annualCalendar: AnnualCalendarResponse) throws
    func read() throws -> [AnnualCalendarEntity]
    func readAtYear(year: String) throws -> AnnualCalendarEntity
}

final class CalendarsRepository: CalendarsRepositoryProtocol {
    
    // MARK: Properties
    
    private let container: ProviderContainer = ProviderContainer.shared
    
    // MARK: Create
    
    func create(annualCalendar: AnnualCalendarResponse) throws {
        let annualCalendarEntity = AnnualCalendarEntity(context: container.persistentContainer.viewContext)
        annualCalendarEntity.year = annualCalendar.year
        container.saveContext()
    }
    
    // MARK: Read
    
    func read() throws -> [AnnualCalendarEntity] {
        let request: NSFetchRequest<AnnualCalendarEntity> = AnnualCalendarEntity.fetchRequest()
        return try container.persistentContainer.viewContext.fetch(request)
    }

    func readAtYear(year: String) throws -> AnnualCalendarEntity {
        let annualCalendarRequest: NSFetchRequest<AnnualCalendarEntity> = AnnualCalendarEntity.fetchRequest()
        
        annualCalendarRequest.predicate = NSPredicate(format: "year = %@", year)
        guard let annualCalendarEntity = try container.persistentContainer.viewContext.fetch(annualCalendarRequest).first else {
            throw CoreError.customError(Constants.MonthlyBillsRepository.calendarNotFound)
        }
        
        return annualCalendarEntity
    }
}
