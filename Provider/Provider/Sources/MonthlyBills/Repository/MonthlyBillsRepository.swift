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
    func updateBillItem(item: BillItemResponse, billId: String) throws
    func updateTemplateItem(item: BillItemResponse) throws
    func deleteItem(itemId: String, billId: String) throws
    func deleteTemplateItem(itemId: String) throws
}

public final class MonthlyBillsRepository: MonthlyBillsRepositoryProtocol {
    
    private let calendarsService: CalendarsServiceProtocol
    private let billsService: BillsServiceProtocol
    private let itemsService: ItemsServiceProtocol
    private let templatesService: TemplatesServiceProtocol
    
    init(
        calendarsService: CalendarsServiceProtocol = CalendarsService(),
        billsService: BillsServiceProtocol = BillsService(),
        itemsService: ItemsServiceProtocol = ItemsService(),
        templatesService: TemplatesServiceProtocol = TemplatesService()
    ) {
        self.calendarsService = calendarsService
        self.billsService = billsService
        self.itemsService = itemsService
        self.templatesService = templatesService
    }
    
    public init() {
        self.calendarsService = CalendarsService()
        self.billsService = BillsService()
        self.itemsService = ItemsService()
        self.templatesService = TemplatesService()
    }
    
    // MARK: Create
    
    public func create(annualCalendar: AnnualCalendarResponse) throws {
        try calendarsService.create(annualCalendar: annualCalendar)
    }
    
    public func createBillItem(item: BillItemResponse, billId: String, billType: BillSectionResponse.BillType) throws {
        try itemsService.create(item: item, billId: billId, billType: billType)
    }
    
    public func createTemplateItem(item: BillItemResponse, billType: BillSectionResponse.BillType) throws {
        try templatesService.create(item: item, billType: billType)
    }
    
    // MARK: Read
    
    public func read() throws -> [AnnualCalendarResponse] {
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
    
    // MARK: Update
    
    public func updateBillItem(item: BillItemResponse, billId: String) throws {
        try itemsService.update(item: item)
    }
    
    public func updateTemplateItem(item: BillItemResponse) throws {
        try templatesService.update(item: item)
    }
    
    // MARK: Delete
    
    public func deleteItem(itemId: String, billId: String) throws {
        try itemsService.delete(id: itemId)
    }
    
    public func deleteTemplateItem(itemId: String) throws {
        try templatesService.delete(itemId: itemId)
    }
}
