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
        
        guard !calendarExists(annualCalendar, in: currentAnnualCalendarsResponses) else {
            throw CoreError.customError(Constants.MonthlyBillsRepository.existentCalendar)
        }
        
        try calendarsRepository.create(annualCalendar: annualCalendar)
        try billsRepository.createMonths(for: try calendarsRepository.readAtYear(year: annualCalendar.year))
    }
    
    func read() throws -> [AnnualCalendarResponse] {
        return try calendarsRepository.read().map(AnnualCalendarResponse.init)
    }
    
    func readAtYear(year: String) throws -> AnnualCalendarResponse {
        let annualCalendarEntity = try calendarsRepository.readAtYear(year: year)
        let monthlyBillsResponses = try buildMonthlyBillsResponses(from: annualCalendarEntity)
        
        var annualCalendarResponse = AnnualCalendarResponse(from: annualCalendarEntity)
        annualCalendarResponse.monthlyBills = monthlyBillsResponses
        
        return sortMonths(of: annualCalendarResponse)
    }
}

private extension CalendarsService {
    
    // MARK: Private Methods
    
    func calendarExists(_ calendar: AnnualCalendarResponse, in calendars: [AnnualCalendarResponse]) -> Bool {
        return calendars.contains { $0.year == calendar.year }
    }
    
    func buildMonthlyBillsResponses(from annualCalendarEntity: AnnualCalendarEntity) throws -> [MonthlyBillsResponse] {
        return try billsRepository.read(from: annualCalendarEntity).map { monthlyBillsEntity in
            let sectionsResponses = try buildSectionsResponses(from: monthlyBillsEntity)
            var monthlyBillsResponse = MonthlyBillsResponse(from: monthlyBillsEntity)
            monthlyBillsResponse.sections = sectionsResponses
            return monthlyBillsResponse
        }
    }
    
    func buildSectionsResponses(from monthlyBillsEntity: MonthlyBillsEntity) throws -> [BillSectionResponse] {
        return try sectionsRepository.read(from: monthlyBillsEntity).compactMap { billSectionEntity in
            let itemsEntities = try itemsRepository.read(from: billSectionEntity)
            guard !itemsEntities.isEmpty else { return nil }
            
            var billSectionResponse = BillSectionResponse(from: billSectionEntity)
            billSectionResponse.items = itemsEntities.map(BillItemResponse.init)
            return billSectionResponse
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
