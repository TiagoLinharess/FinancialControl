//
//  BillsService.swift
//  Provider
//
//  Created by Tiago Linhares on 12/03/24.
//

import CoreData
import Foundation
import SharpnezCore

protocol BillsServiceProtocol {
    func readAtMonth(id: String) throws -> MonthlyBillsResponse
    func readAtMonthWithTemplates(billId: String) throws -> MonthlyBillsResponse
}

final class BillsService: BillsServiceProtocol {
    
    // MARK: Properties
    
    private let billsRepository: BillsRepositoryProtocol
    private let sectionsRepository: SectionsRepositoryProtocol
    private let itemsRepository: ItemsRepositoryProtocol
    private let installmentsRepository: InstallmentsRepositoryProtocol
    private let templatesRepository: TemplatesRepositoryProtocol
    
    // MARK: Init
    
    init(
        billsRepository: BillsRepositoryProtocol = BillsRepository(),
        sectionsRepository: SectionsRepositoryProtocol = SectionsRepository(),
        itemsRepository: ItemsRepositoryProtocol = ItemsRepository(),
        installmentsRepository: InstallmentsRepositoryProtocol = InstallmentsRepository(),
        templatesRepository: TemplatesRepositoryProtocol = TemplatesRepository()
    ) {
        self.billsRepository = billsRepository
        self.sectionsRepository = sectionsRepository
        self.itemsRepository = itemsRepository
        self.installmentsRepository = installmentsRepository
        self.templatesRepository = templatesRepository
    }
    
    // MARK: Read
    
    func readAtMonth(id: String) throws -> MonthlyBillsResponse {
        let monthlyBillsEntity = try billsRepository.readAtMonth(id: id)
        let sectionsResponses = try fetchSections(for: monthlyBillsEntity)
        
        var monthlyBillsResponse = MonthlyBillsResponse(from: monthlyBillsEntity)
        monthlyBillsResponse.sections = sectionsResponses
        return monthlyBillsResponse
    }
    
    func readAtMonthWithTemplates(billId: String) throws -> MonthlyBillsResponse {
        let templates = try templatesRepository.read()
        let monthlyBillsEntity = try billsRepository.readAtMonth(id: billId)
        
        try templates.forEach { sectionResponse in
            let sectionEntity = try sectionsRepository.readAt(
                billType: sectionResponse.type,
                monthlyBillsEntity: monthlyBillsEntity
            ) ?? sectionsRepository.createAndRead(
                billType: sectionResponse.type,
                monthlyBillsEntity: monthlyBillsEntity
            )
            
            try createItems(items: sectionResponse.items, billId: billId, billSectionEntity: sectionEntity)
        }

        return try readAtMonth(id: billId)
    }
}

private extension BillsService {
    
    // MARK: Private Methods
    
    private func fetchSections(for monthlyBillsEntity: MonthlyBillsEntity) throws -> [BillSectionResponse] {
        return try sectionsRepository.read(from: monthlyBillsEntity)
            .compactMap { try billSectionEntityToResponse(billSectionEntity: $0) }
            .sorted { $0.type.order < $1.type.order }
    }
    
    private func fetchItems(for sectionEntity: BillSectionEntity) throws -> [BillItemResponse] {
        let itemsEntities = try itemsRepository.read(from: sectionEntity)
        return try itemsEntities.map { billItemEntity -> BillItemResponse in
            var itemResponse = BillItemResponse(from: billItemEntity)
            itemResponse.installment = try fetchInstallment(billItemEntity: billItemEntity)
            return itemResponse
        }
    }
    
    private func fetchInstallment(billItemEntity: BillItemEntity) throws -> BillItemResponse.BillInstallment? {
        guard let entity = try installmentsRepository.read(from: billItemEntity) else { return nil }
        return BillItemResponse.BillInstallment(from: entity)
    }
    
    private func billSectionEntityToResponse(billSectionEntity: BillSectionEntity) throws -> BillSectionResponse? {
        var billSectionResponse = BillSectionResponse(from: billSectionEntity)
        billSectionResponse.items = try fetchItems(for: billSectionEntity)
        return billSectionResponse.items.isEmpty ? nil : billSectionResponse
    }
    
    private func createItems(items: [BillItemResponse], billId: String, billSectionEntity: BillSectionEntity) throws {
        try items.forEach { itemResponse in
            let itemResponse = BillItemResponse(
                id: UUID().uuidString,
                name: itemResponse.name,
                value: itemResponse.value,
                status: itemResponse.status,
                installment: itemResponse.installment
            )
            try itemsRepository.create(item: itemResponse, billId: billId, billSectionEntity: billSectionEntity)
            
            if let installmentResponse = itemResponse.installment,
               let billItemEntity = try? itemsRepository.readAt(id: itemResponse.id) {
                try installmentsRepository.create(installmentResponse: installmentResponse, billItemEntity: billItemEntity)
            }
        }
    }
}
