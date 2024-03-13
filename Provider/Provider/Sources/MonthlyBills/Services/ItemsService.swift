//
//  ItemsService.swift
//  Provider
//
//  Created by Tiago Linhares on 12/03/24.
//

import CoreData
import Foundation
import SharpnezCore

protocol ItemsServiceProtocol {
    func create(item: BillItemResponse, billId: String, billType: BillSectionResponse.BillType) throws
}

final class ItemsService: ItemsServiceProtocol {
    
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
    
    // MARK: Create
    
    func create(item: BillItemResponse, billId: String, billType: BillSectionResponse.BillType) throws {
        let monthlyBillsEntity = try billsRepository.readAtMonth(id: billId)
        let billSectionEntity = try fetchOrCreateSection(monthlyBillsEntity: monthlyBillsEntity, billType: billType)
        
        try itemsRepository.create(item: item, billId: billId, billSectionEntity: billSectionEntity)
    }
}

private extension ItemsService {
    
    // MARK: Private Mehtods
    
    func fetchOrCreateSection(monthlyBillsEntity: MonthlyBillsEntity, billType: BillSectionResponse.BillType) throws -> BillSectionEntity {
        if let billSectionEntity = try sectionsRepository.readAt(billType: billType, monthlyBillsEntity: monthlyBillsEntity) {
            return billSectionEntity
        }
        
        return try sectionsRepository.createAndRead(billType: billType, monthlyBillsEntity: monthlyBillsEntity)
    }
}