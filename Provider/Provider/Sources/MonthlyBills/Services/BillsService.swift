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
}
