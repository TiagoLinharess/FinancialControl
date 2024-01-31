//
//  MonthlyBillsRepository.swift
//  Provider
//
//
//  Created by Tiago Linhares on 30/11/23.
//

import Foundation
import SharpnezCore

public protocol MonthlyBillsRepositoryProtocol {
    func create(annualCalendar: AnnualCalendarResponse) throws
    func createBillItem(item: BillItemResponse, billId: String, billType: BillSectionResponse.BillType) throws
    func read() throws -> [AnnualCalendarResponse]
    func readAtYear(year: String) throws -> AnnualCalendarResponse
    func readAtMonth(id: String) throws -> MonthlyBillsResponse
    func updateBillItem(item: BillItemResponse, billId: String) throws
    func deleteItem(itemId: String, billId: String) throws
}

public final class MonthlyBillsRepository: MonthlyBillsRepositoryProtocol {
    
    let key: String
    
    public init(key: String? = nil) {
        self.key = key ?? Constants.UserDefaultsKeys.bills
    }
    
    // MARK: Create
    
    public func create(annualCalendar: AnnualCalendarResponse) throws {
        var currentCalendars = try read()
        
        if compareCalendars(calendar: annualCalendar, currentCalendars: currentCalendars) {
            throw CoreError.customError(Constants.MonthlyBillsRepository.existentCalendar)
        }
        
        currentCalendars.insert(annualCalendar, at: .zero)
        
        let data = try JSONEncoder().encode(currentCalendars)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    public func createBillItem(item: BillItemResponse, billId: String, billType: BillSectionResponse.BillType) throws {
        var calendars = try read()
        let (calendarIndex, billIndex) = try findCalendarAndBillIndices(for: billId)
        var bill = calendars[calendarIndex].monthlyBills[billIndex]
        
        if let sectionIndex = bill.sections.firstIndex(where: { $0.type == billType }) {
            bill.sections[sectionIndex].items.append(item)
        } else if billType == .income {
            bill.sections.insert(BillSectionResponse(items: [item], type: billType), at: 0)
        } else {
            bill.sections.append(BillSectionResponse(items: [item], type: billType))
        }
        
        calendars[calendarIndex].monthlyBills[billIndex] = bill
        
        let data = try JSONEncoder().encode(calendars)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    // MARK: Read
    
    public func read() throws -> [AnnualCalendarResponse] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        let response = try JSONDecoder().decode([AnnualCalendarResponse].self, from: data)
        return response
    }
    
    public func readAtYear(year: String) throws -> AnnualCalendarResponse {
        let currentCalendars = try read()
        
        guard let calendar = currentCalendars.first(where: { calendar in
            calendar.year == year
        }) else {
            throw CoreError.customError(Constants.MonthlyBillsRepository.calendarNotFound)
        }
        
        return calendar
    }
    
    public func readAtMonth(id: String) throws -> MonthlyBillsResponse {
        let calendars = try read()
        
        for calendar in calendars {
            if let bill = calendar.monthlyBills.first(where: { $0.id == id }) {
                return bill
            }
        }
        
        throw CoreError.customError(Constants.MonthlyBillsRepository.billNotFound)
    }
    
    // MARK: Update
    
    public func updateBillItem(item: BillItemResponse, billId: String) throws {
        var calendars = try read()
        let (calendarIndex, billIndex) = try findCalendarAndBillIndices(for: billId)
        let (sectionIndex, itemIndex) = try findSectionAndItemIndices(itemId: item.id, billId: billId)
        
        calendars[calendarIndex].monthlyBills[billIndex].sections[sectionIndex].items[itemIndex] = item
        let data = try JSONEncoder().encode(calendars)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    // MARK: Delete
    
    public func deleteItem(itemId: String, billId: String) throws {
        var calendars = try read()
        let (calendarIndex, billIndex) = try findCalendarAndBillIndices(for: billId)
        let (sectionIndex, itemIndex) = try findSectionAndItemIndices(itemId: itemId, billId: billId)
        
        if calendars[calendarIndex].monthlyBills[billIndex].sections[sectionIndex].items.count == 1 {
            calendars[calendarIndex].monthlyBills[billIndex].sections.remove(at: sectionIndex)
        } else {
            calendars[calendarIndex].monthlyBills[billIndex].sections[sectionIndex].items.remove(at: itemIndex)
        }
        
        let data = try JSONEncoder().encode(calendars)
        UserDefaults.standard.set(data, forKey: key)
    }
}

private extension MonthlyBillsRepository {
    
    // MARK: Private Methods
    
    func compareCalendars(calendar: AnnualCalendarResponse, currentCalendars: [AnnualCalendarResponse]) -> Bool {
        currentCalendars.contains { currentCalendar in
            return currentCalendar.year == calendar.year
        }
    }
    
    func findCalendarAndBillIndices(for billId: String) throws -> (calendarIndex: Int, billIndex: Int) {
        let calendars = try read()
        
        for (calendarIndex, calendar) in calendars.enumerated() {
            if let billIndex = calendar.monthlyBills.firstIndex(where: { $0.id == billId }) {
                return (calendarIndex, billIndex)
            }
        }
        
        throw CoreError.customError(Constants.MonthlyBillsRepository.billNotFound)
    }
    
    func findSectionAndItemIndices(itemId: String, billId: String) throws -> (sectionIndex: Int, itemIndex: Int) {
        let bill = try readAtMonth(id: billId)
        
        for (sectionIndex, section) in bill.sections.enumerated() {
            if let itemIndex = section.items.firstIndex(where: { $0.id == itemId }) {
                return (sectionIndex, itemIndex)
            }
        }
        
        throw CoreError.customError(Constants.MonthlyBillsRepository.itemNotFound)
    }
}
