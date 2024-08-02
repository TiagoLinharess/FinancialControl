//
//  BillTypeResponse.swift
//  Provider
//
//  Created by Tiago Linhares on 08/06/24.
//

import Foundation

public struct BillTypeResponse: Codable {
    
    // MARK: Properties
    
    public let id: String
    public let name: String
    public var isIncome: Bool
    
    // MARK: Init
    
    public init(id: String, name: String, isIncome: Bool) {
        self.id = id
        self.name = name
        self.isIncome = isIncome
    }
}
