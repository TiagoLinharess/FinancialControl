//
//  BillsRepository.swift
//  Provider
//
//  Created by Tiago Linhares on 29/02/24.
//

//import CoreData
//import Foundation
//
//protocol CalendarsRepositoryProtocol {
//    func create(annualCalendar: AnnualCalendarResponse) throws
//    func read() throws -> [AnnualCalendarResponse]
//    func readAtYear(year: String) throws -> AnnualCalendarResponse
//}
//
//final class CalendarsRepository: CalendarsRepositoryProtocol {
//    
//    // MARK: Properties
//    
//    private let container: ProviderContainer = .init()
//    
//    // MARK: Create
//    
//    func create(annualCalendar: AnnualCalendarResponse) throws {
//        let annualCalendarEntity = AnnualCalendarEntity(context: container.persistentContainer.viewContext)
//        annualCalendarEntity.year = annualCalendar.year
//        container.saveContext()
//    }
//    
//    // MARK: Read
//    
//    func read() throws -> [AnnualCalendarResponse] {
//        <#code#>
//    }
//
//    func readAtYear(year: String) throws -> AnnualCalendarResponse {
//        <#code#>
//    }
//}
