//
//  BillSectionResponse.swift
//  Provider
//
//  Created by Tiago Linhares on 24/01/24.
//

import Foundation

public struct BillSectionResponse: Codable {
    
    // MARK: Properties
    
    public var items: [BillItemResponse]
    public let type: BillTypeResponse
    
    // MARK: Init
    
    public init(items: [BillItemResponse], type: BillTypeResponse) {
        self.items = items
        self.type = type
    }
    
    // MARK: Init From Entity
    
    public init?(from entity: BillSectionEntity) {
        self.items = []
        
        guard let name = entity.type, let id = entity.id else {
            return nil
        }
        
        self.type = BillTypeResponse(
            id: id,
            name: name,
            isIncome: entity.isIncome
        )
    }
}
