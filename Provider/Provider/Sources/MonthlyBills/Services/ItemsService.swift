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
    func update(item: BillItemResponse) throws
    func delete(id: String) throws
}

final class ItemsService: ItemsServiceProtocol {
    
    // MARK: Properties
    
    private let billsRepository: BillsRepositoryProtocol
    private let sectionsRepository: SectionsRepositoryProtocol
    private let itemsRepository: ItemsRepositoryProtocol
    private let installmentsRepository: InstallmentsRepositoryProtocol
    
    // MARK: Init
    
    init(
        billsRepository: BillsRepositoryProtocol = BillsRepository(),
        sectionsRepository: SectionsRepositoryProtocol = SectionsRepository(),
        itemsRepository: ItemsRepositoryProtocol = ItemsRepository(),
        installmentsRepository: InstallmentsRepositoryProtocol = InstallmentsRepository()
    ) {
        self.billsRepository = billsRepository
        self.sectionsRepository = sectionsRepository
        self.itemsRepository = itemsRepository
        self.installmentsRepository = installmentsRepository
    }
    
    // MARK: Create
    
    func create(item: BillItemResponse, billId: String, billType: BillSectionResponse.BillType) throws {
        let monthlyBillsEntity = try billsRepository.readAtMonth(id: billId)
        let billSectionEntity = try fetchOrCreateSection(monthlyBillsEntity: monthlyBillsEntity, billType: billType)
        
        try itemsRepository.create(item: item, billId: billId, billSectionEntity: billSectionEntity)
        
        if let installmentResponse = item.installment {
            guard let billItemEntity = try? itemsRepository.readAt(id: item.id) else {
                throw CoreError.customError(Constants.MonthlyBillsRepository.itemNotFound)
            }
            
            try installmentsRepository.create(installmentResponse: installmentResponse, billItemEntity: billItemEntity)
        }
    }
    
    // MARK: Update
    
    func update(item: BillItemResponse) throws {
        try itemsRepository.update(item: item)
        
        if let installmentResponse = item.installment {
            guard let billItemEntity = try? itemsRepository.readAt(id: item.id) else {
                throw CoreError.customError(Constants.MonthlyBillsRepository.itemNotFound)
            }
            
            try installmentsRepository.update(installmentResponse: installmentResponse, billItemEntity: billItemEntity)
        }
    }
    
    // MARK: Delete
    
    func delete(id: String) throws {
        if let billItemEntity = try? itemsRepository.readAt(id: id),
           let _ = try? installmentsRepository.read(from: billItemEntity)
        {
            try installmentsRepository.delete(billItemEntity: billItemEntity)
        }
        
        try itemsRepository.delete(id: id)
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
