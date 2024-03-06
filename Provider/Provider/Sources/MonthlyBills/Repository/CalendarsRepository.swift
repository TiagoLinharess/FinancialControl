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
    func read() throws -> [AnnualCalendarResponse]
    func readAtYear(year: String) throws -> AnnualCalendarResponse
}

final class CalendarsRepository: CalendarsRepositoryProtocol {
    
    // MARK: Properties
    
    private let container: ProviderContainer = .init()
    
    // MARK: Create
    
    func create(annualCalendar: AnnualCalendarResponse) throws {
        let currentAnnualCalendarsResponses = try read()
        
        if compareCalendars(calendar: annualCalendar, currentCalendars: currentAnnualCalendarsResponses) {
            throw CoreError.customError(Constants.MonthlyBillsRepository.existentCalendar)
        }
        
        let annualCalendarEntity = AnnualCalendarEntity(context: container.persistentContainer.viewContext)
        annualCalendarEntity.year = annualCalendar.year
        createMonths(for: annualCalendarEntity)
        container.saveContext()
    }
    
    // MARK: Read
    
    func read() throws -> [AnnualCalendarResponse] {
        let request: NSFetchRequest<AnnualCalendarEntity> = AnnualCalendarEntity.fetchRequest()
        let annualCalendarEntities = try container.persistentContainer.viewContext.fetch(request)
        return annualCalendarEntities.map { entity -> AnnualCalendarResponse in return AnnualCalendarResponse(from: entity, with: []) }
    }

    func readAtYear(year: String) throws -> AnnualCalendarResponse {
        let annualCalendarRequest: NSFetchRequest<AnnualCalendarEntity> = AnnualCalendarEntity.fetchRequest()
        let monthlyBillsRequest: NSFetchRequest<MonthlyBillsEntity> = MonthlyBillsEntity.fetchRequest()
        
        annualCalendarRequest.predicate = NSPredicate(format: "year = %@", year)
        guard let annualCalendarEntity = try container.persistentContainer.viewContext.fetch(annualCalendarRequest).first else {
            throw CoreError.customError(Constants.MonthlyBillsRepository.calendarNotFound)
        }
        
        monthlyBillsRequest.predicate = NSPredicate(format: "year = %@", annualCalendarEntity)
        let monthlyBillsEntities = try container.persistentContainer.viewContext.fetch(monthlyBillsRequest)
        
        return sortMonths(of: AnnualCalendarResponse(from: annualCalendarEntity, with: monthlyBillsEntities))
    }
}

private extension CalendarsRepository {
    
    // MARK: Private methods
    
    func compareCalendars(calendar: AnnualCalendarResponse, currentCalendars: [AnnualCalendarResponse]) -> Bool {
        currentCalendars.contains { currentCalendar in
            return currentCalendar.year == calendar.year
        }
    }
    
    func createMonths(for annualCalendarEntity: AnnualCalendarEntity) {
        Calendar.current.monthSymbols.forEach { month in
            let monthlyBillsEntity = MonthlyBillsEntity(context: container.persistentContainer.viewContext)
            monthlyBillsEntity.id = UUID().uuidString
            monthlyBillsEntity.month = month
            annualCalendarEntity.addToMonths(monthlyBillsEntity)
        }
    }
    
    func sortMonths(of annualCalendarResponse: AnnualCalendarResponse) -> AnnualCalendarResponse {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        
        let sortedMonths = annualCalendarResponse.monthlyBills.sorted {
            guard let month0 = formatter.date(from: $0.month),
                  let month1 = formatter.date(from: $1.month)
            else { return false }
            
            return month0 < month1
        }
        
        return AnnualCalendarResponse(year: annualCalendarResponse.year, monthlyBills: sortedMonths)
    }
}
