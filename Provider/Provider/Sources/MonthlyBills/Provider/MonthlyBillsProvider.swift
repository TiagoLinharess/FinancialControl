//
//  MonthlyBillsRepository.swift
//  Provider
//
//
//  Created by Tiago Linhares on 30/11/23.
//

import Foundation
import SharpnezCore

public protocol MonthlyBillsProviderProtocol {
    
    /// Create
    func createCalendar(annualCalendar: AnnualCalendarResponse) throws
    func createBillItem(item: BillItemResponse, billId: String, billType: BillTypeResponse) throws
    func createTemplateItem(item: BillItemResponse, billType: BillTypeResponse) throws
    func createBillType(name: String) throws
    
    /// Read
    func readCalendar() throws -> [AnnualCalendarResponse]
    func readAtYear(year: String) throws -> AnnualCalendarResponse
    func readAtMonth(id: String) throws -> MonthlyBillsResponse
    func readAtMonthWithTemplates(billId: String) throws -> MonthlyBillsResponse
    func readTemplates() throws -> [BillSectionResponse]
    func readTemplateAt(id: String) throws -> BillItemResponse
    func readBillTypes() throws -> [BillTypeResponse]
    
    /// Update
    func updateBillItem(item: BillItemResponse, billId: String) throws
    func updateTemplateItem(item: BillItemResponse) throws
    func updateBillType(id: String) throws
    func updateBillTypesOrder(billTypes: [BillTypeResponse]) throws
    
    /// Delete
    func deleteItem(itemId: String, billId: String) throws
    func deleteTemplateItem(itemId: String) throws
    func deleteBillType(id: String) throws
}

public final class MonthlyBillsProvider: MonthlyBillsProviderProtocol {
    
    private let calendarsService: CalendarsServiceProtocol
    private let billsService: BillsServiceProtocol
    private let itemsService: ItemsServiceProtocol
    private let templatesService: TemplatesServiceProtocol
    private let billTypeService: BillTypeServiceProtocol
    
    init(
        calendarsService: CalendarsServiceProtocol = CalendarsService(),
        billsService: BillsServiceProtocol = BillsService(),
        itemsService: ItemsServiceProtocol = ItemsService(),
        templatesService: TemplatesServiceProtocol = TemplatesService(),
        billTypeService: BillTypeServiceProtocol = BillTypeService()
    ) {
        self.calendarsService = calendarsService
        self.billsService = billsService
        self.itemsService = itemsService
        self.templatesService = templatesService
        self.billTypeService = billTypeService
    }
    
    public init() {
        self.calendarsService = CalendarsService()
        self.billsService = BillsService()
        self.itemsService = ItemsService()
        self.templatesService = TemplatesService()
        self.billTypeService = BillTypeService()
    }
    
    // MARK: Create
    
    public func createCalendar(annualCalendar: AnnualCalendarResponse) throws {
        try calendarsService.create(annualCalendar: annualCalendar)
    }
    
    public func createBillItem(item: BillItemResponse, billId: String, billType: BillTypeResponse) throws {
        try itemsService.create(item: item, billId: billId, billType: billType)
    }
    
    public func createTemplateItem(item: BillItemResponse, billType: BillTypeResponse) throws {
        try templatesService.create(item: item, billType: billType)
    }
    
    public func createBillType(name: String) throws {
        try billTypeService.create(name: name)
    }
    
    // MARK: Read
    
    public func readCalendar() throws -> [AnnualCalendarResponse] {
        return try calendarsService.read()
    }
    
    public func readAtYear(year: String) throws -> AnnualCalendarResponse {
        return try calendarsService.readAtYear(year: year)
    }
    
    public func readAtMonth(id: String) throws -> MonthlyBillsResponse {
        return try billsService.readAtMonth(id: id)
    }
    
    public func readAtMonthWithTemplates(billId: String) throws -> MonthlyBillsResponse {
        return try billsService.readAtMonthWithTemplates(billId: billId)
    }
    
    public func readTemplates() throws -> [BillSectionResponse] {
        return try templatesService.read()
    }
    
    public func readTemplateAt(id: String) throws -> BillItemResponse {
        return try templatesService.readAt(id: id)
    }
    
    public func readBillTypes() throws -> [BillTypeResponse] {
        return try billTypeService.read()
    }
    
    // MARK: Update
    
    public func updateBillItem(item: BillItemResponse, billId: String) throws {
        try itemsService.update(item: item)
    }
    
    public func updateTemplateItem(item: BillItemResponse) throws {
        try templatesService.update(item: item)
    }
    
    public func updateBillType(id: String) throws {
        try billTypeService.update(id: id)
    }
    
    public func updateBillTypesOrder(billTypes: [BillTypeResponse]) throws {
        try billTypeService.updateOrder(billTypes: billTypes)
    }
    
    // MARK: Delete
    
    public func deleteItem(itemId: String, billId: String) throws {
        try itemsService.delete(id: itemId)
    }
    
    public func deleteTemplateItem(itemId: String) throws {
        try templatesService.delete(itemId: itemId)
    }
    
    public func deleteBillType(id: String) throws {
        try billTypeService.delete(id: id)
    }
}
