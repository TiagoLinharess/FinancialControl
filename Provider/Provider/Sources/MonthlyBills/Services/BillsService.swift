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
}

final class BillsService: BillsServiceProtocol {
    
    // MARK: Properties
    
    private let billsRepository: BillsRepositoryProtocol
    private let sectionsRepository: SectionsRepositoryProtocol
    private let itemsRepository: ItemsRepositoryProtocol
    
    // MARK: Init
    
    init(
        billsRepository: BillsRepositoryProtocol = BillsRepository(),
        sectionsRepository: SectionsRepositoryProtocol = SectionsRepository(),
        itemsRepository: ItemsRepositoryProtocol = ItemsRepository()
    ) {
        self.billsRepository = billsRepository
        self.sectionsRepository = sectionsRepository
        self.itemsRepository = itemsRepository
    }
    
    // MARK: Read
    
    func readAtMonth(id: String) throws -> MonthlyBillsResponse {
        let monthlyBillsEntity = try billsRepository.readAtMonth(id: id)
        let sectionsResponses = try fetchSections(for: monthlyBillsEntity)
        
        var monthlyBillsResponse = MonthlyBillsResponse(from: monthlyBillsEntity)
        monthlyBillsResponse.sections = sectionsResponses
        return monthlyBillsResponse
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
        return itemsEntities.map(BillItemResponse.init)
    }
    
    private func billSectionEntityToResponse(billSectionEntity: BillSectionEntity) throws -> BillSectionResponse? {
        var billSectionResponse = BillSectionResponse(from: billSectionEntity)
        billSectionResponse.items = try fetchItems(for: billSectionEntity)
        return billSectionResponse.items.isEmpty ? nil : billSectionResponse
    }
}
