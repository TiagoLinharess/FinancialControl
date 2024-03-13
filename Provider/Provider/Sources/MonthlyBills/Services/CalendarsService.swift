//
//  CalendarsService.swift
//  Provider
//
//  Created by Tiago Linhares on 12/03/24.
//

import Foundation
import SharpnezCore

protocol CalendarsServiceProtocol {
    func create(annualCalendar: AnnualCalendarResponse) throws
    func read() throws -> [AnnualCalendarResponse]
    func readAtYear(year: String) throws -> AnnualCalendarResponse
}

final class CalendarsService: CalendarsServiceProtocol {
    
    // MARK: Properties
    
    private let calendarsRepository: CalendarsRepositoryProtocol
    private let billsRepository: BillsRepositoryProtocol
    private let sectionsRepository: SectionsRepositoryProtocol
    private let itemsRepository: ItemsRepositoryProtocol
    
    // MARK: Init
    
    init(
        calendarsRepository: CalendarsRepositoryProtocol = CalendarsRepository(),
        billsRepository: BillsRepositoryProtocol = BillsRepository(),
        sectionsRepository: SectionsRepositoryProtocol = SectionsRepository(),
        itemsRepository: ItemsRepositoryProtocol = ItemsRepository()
    ) {
        self.calendarsRepository = calendarsRepository
        self.billsRepository = billsRepository
        self.sectionsRepository = sectionsRepository
        self.itemsRepository = itemsRepository
    }
    
    func create(annualCalendar: AnnualCalendarResponse) throws {
        let currentAnnualCalendarsResponses = try read()
        
        if compareCalendars(calendar: annualCalendar, currentCalendars: currentAnnualCalendarsResponses) {
            throw CoreError.customError(Constants.MonthlyBillsRepository.existentCalendar)
        }
        
        try calendarsRepository.create(annualCalendar: annualCalendar)
        try billsRepository.createMonths(for: try calendarsRepository.readAtYear(year: annualCalendar.year))
    }
    
    func read() throws -> [AnnualCalendarResponse] {
        let annualCalendarEntities = try calendarsRepository.read()
        return annualCalendarEntities.map { entity -> AnnualCalendarResponse in return AnnualCalendarResponse(from: entity) }
    }
    
    func readAtYear(year: String) throws -> AnnualCalendarResponse {
        let annualCalendarEntity = try calendarsRepository.readAtYear(year: year)
        let monthlyBillsEntities = try billsRepository.read(from: annualCalendarEntity)
        
        let monthlyBillsResponses = try monthlyBillsEntities.map { monthlyBillsEntity -> MonthlyBillsResponse in
            let sectionsEntities = try sectionsRepository.read(from: monthlyBillsEntity)
            let sectionsResponses = try sectionsEntities.compactMap { billSectionEntity -> BillSectionResponse? in
                let itemsEntities = try itemsRepository.read(from: billSectionEntity)
                
                if itemsEntities.isEmpty {
                    return nil
                }
                
                var billSectionResponse = BillSectionResponse(from: billSectionEntity)
                billSectionResponse.items = itemsEntities.map { itemEntity -> BillItemResponse in return BillItemResponse(from: itemEntity) }
                return billSectionResponse
            }
            
            var monthlyBillsResponse = MonthlyBillsResponse(from: monthlyBillsEntity)
            monthlyBillsResponse.sections = sectionsResponses
            return monthlyBillsResponse
        }
        
        var annualCalendarResponse = AnnualCalendarResponse(from: annualCalendarEntity)
        annualCalendarResponse.monthlyBills = monthlyBillsResponses
        
        return sortMonths(of: annualCalendarResponse)
    }
}

private extension CalendarsService {
    
    // MARK: Private Methods
    
    func compareCalendars(calendar: AnnualCalendarResponse, currentCalendars: [AnnualCalendarResponse]) -> Bool {
        currentCalendars.contains { currentCalendar in
            return currentCalendar.year == calendar.year
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
