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
    func createTemplateItem(item: BillItemResponse, billType: BillSectionResponse.BillType) throws
    func read() throws -> [AnnualCalendarResponse]
    func readAtYear(year: String) throws -> AnnualCalendarResponse
    func readAtMonth(id: String) throws -> MonthlyBillsResponse
    func readAtMonthWithTemplates(billId: String) throws -> MonthlyBillsResponse
    func readTemplates() throws -> [BillSectionResponse]
    func readTemplateAt(id: String) throws -> BillItemResponse
    func updateBill(bill: MonthlyBillsResponse) throws
    func updateBillItem(item: BillItemResponse, billId: String) throws
    func updateTemplateItem(item: BillItemResponse) throws
    func deleteItem(itemId: String, billId: String) throws
    func deleteTemplateItem(itemId: String) throws
}

public final class MonthlyBillsRepository: MonthlyBillsRepositoryProtocol {
    
    let key: String
    let templateKey: String
    
    public init(key: String? = nil, templateKey: String? = nil) {
        self.key = key ?? Constants.UserDefaultsKeys.bills
        self.templateKey = templateKey ?? Constants.UserDefaultsKeys.billsTemplate
    }
    
    // MARK: Create
    
    public func create(annualCalendar: AnnualCalendarResponse) throws {
        let repository = CalendarsRepository()
        try repository.create(annualCalendar: annualCalendar)
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
    
    public func createTemplateItem(item: BillItemResponse, billType: BillSectionResponse.BillType) throws {
        var templates = try readTemplates()
        
        if let sectionIndex = templates.firstIndex(where: { $0.type == billType }) {
            templates[sectionIndex].items.append(item)
        } else if billType == .income {
            templates.insert(BillSectionResponse(items: [item], type: billType), at: 0)
        } else {
            templates.append(BillSectionResponse(items: [item], type: billType))
        }
        
        let data = try JSONEncoder().encode(templates)
        UserDefaults.standard.set(data, forKey: templateKey)
    }
    
    // MARK: Read
    
    public func read() throws -> [AnnualCalendarResponse] {
        let repository = CalendarsRepository()
        return try repository.read()
    }
    
    public func readAtYear(year: String) throws -> AnnualCalendarResponse {
        let repository = CalendarsRepository()
        return try repository.readAtYear(year: year)
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
    
    public func readAtMonthWithTemplates(billId: String) throws -> MonthlyBillsResponse {
        let calendars = try read()
        let templates = try readTemplates()
        
        for calendar in calendars {
            if var bill = calendar.monthlyBills.first(where: { $0.id == billId }) {
                bill.sections = templates
                try updateBill(bill: bill)
                return bill
            }
        }
        
        throw CoreError.customError(Constants.MonthlyBillsRepository.billNotFound)
    }
    
    public func readTemplates() throws -> [BillSectionResponse] {
        guard let data = UserDefaults.standard.data(forKey: templateKey) else { return [] }
        let response = try JSONDecoder().decode([BillSectionResponse].self, from: data)
        return response
    }
    
    public func readTemplateAt(id: String) throws -> BillItemResponse {
        let templates = try readTemplates()
        
        for template in templates {
            if let bill = template.items.first(where: { $0.id == id }) {
                return bill
            }
        }
        
        throw CoreError.customError(Constants.MonthlyBillsRepository.templateNotFound)
    }
    
    // MARK: Update
    
    public func updateBill(bill: MonthlyBillsResponse) throws {
        var calendars = try read()
        let (calendarIndex, billIndex) = try findCalendarAndBillIndices(for: bill.id)
        
        calendars[calendarIndex].monthlyBills[billIndex] = bill
        let data = try JSONEncoder().encode(calendars)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    public func updateBillItem(item: BillItemResponse, billId: String) throws {
        var calendars = try read()
        let (calendarIndex, billIndex) = try findCalendarAndBillIndices(for: billId)
        let (sectionIndex, itemIndex) = try findSectionAndItemIndices(itemId: item.id, billId: billId)
        
        calendars[calendarIndex].monthlyBills[billIndex].sections[sectionIndex].items[itemIndex] = item
        let data = try JSONEncoder().encode(calendars)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    public func updateTemplateItem(item: BillItemResponse) throws {
        var templates = try readTemplates()
        let (templateIndex, itemIndex) = try findTemplateAndItemIndices(itemId: item.id)
        
        templates[templateIndex].items[itemIndex] = item
        
        let data = try JSONEncoder().encode(templates)
        UserDefaults.standard.set(data, forKey: templateKey)
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
    
    public func deleteTemplateItem(itemId: String) throws {
        var templates = try readTemplates()
        let (templateIndex, itemIndex) = try findTemplateAndItemIndices(itemId: itemId)
        
        if templates[templateIndex].items.count == 1 {
            templates.remove(at: templateIndex)
        } else {
            templates[templateIndex].items.remove(at: itemIndex)
        }
        
        let data = try JSONEncoder().encode(templates)
        UserDefaults.standard.set(data, forKey: templateKey)
    }
}

private extension MonthlyBillsRepository {
    
    // MARK: Private Methods
    
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
    
    func findTemplateAndItemIndices(itemId: String) throws -> (sectionIndex: Int, itemIndex: Int) {
        let templates = try readTemplates()
        
        for (templateIndex, template) in templates.enumerated() {
            if let itemIndex = template.items.firstIndex(where: { $0.id == itemId }) {
                return (templateIndex, itemIndex)
            }
        }
        
        throw CoreError.customError(Constants.MonthlyBillsRepository.itemNotFound)
    }
}
