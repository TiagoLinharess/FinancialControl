//
//  BillSectionResponse.swift
//  Provider
//
//  Created by Tiago Linhares on 24/01/24.
//

import Foundation

public struct BillSectionResponse: Codable {
    
    // MARK: Bill Type
    
    public enum BillType: String, Codable {
        case income
        case investment
        case expense
        case creditCard
    }
    
    // MARK: Properties
    
    public var items: [BillItemResponse]
    public let type: BillType
    
    // MARK: Init
    
    public init(items: [BillItemResponse], type: BillType) {
        self.items = items
        self.type = type
    }
}
