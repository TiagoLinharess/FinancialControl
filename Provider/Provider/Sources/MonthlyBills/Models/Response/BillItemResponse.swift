//
//  BillItemResponse.swift
//  Provider
//
//  Created by Tiago Linhares on 24/01/24.
//

import Foundation

public struct BillItemResponse: Codable {
    
    // MARK: Bill Status
    
    public enum BillStatus: String, Codable {
        case payed
        case pending
    }
    
    // MARK: Installment
    
    public struct BillInstallment: Codable {
        
        public let current: Int
        public let max: Int
        
        public init(current: Int, max: Int) {
            self.current = current
            self.max = max
        }
    }
    
    // MARK: Properties
    
    public let id: String
    public let name: String
    public let value: Double
    public let status: BillStatus
    public var installment: BillInstallment?
    
    // MARK: Init
    
    public init(id: String, name: String, value: Double, status: BillStatus, installment: BillInstallment?) {
        self.id = id
        self.name = name
        self.value = value
        self.status = status
        self.installment = installment
    }
    
    // MARK: Init From Entity
    
    public init(from entity: BillItemEntity) {
        self.id = entity.id ?? String()
        self.name = entity.name ?? String()
        self.value = entity.value
        self.installment = nil
        
        guard let statusString = entity.status else {
            self.status = .pending
            return
        }
        
        self.status = BillStatus(rawValue: statusString) ?? .pending
    }
}
