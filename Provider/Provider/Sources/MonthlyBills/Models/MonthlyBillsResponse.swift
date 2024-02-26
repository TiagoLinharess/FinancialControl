//
//  MonthlyBillsResponse.swift
//  Provider
//
//  Created by Tiago Linhares on 30/11/23.
//

import Foundation

public struct MonthlyBillsResponse: Codable {
    
    // MARK: Properties
    
    public let id: String
    public let month: String
    public var sections: [BillSectionResponse]
    
    // MARK: Init
    
    public init(
        id: String,
        month: String,
        sections: [BillSectionResponse]
    ) {
        self.id = id
        self.month = month
        self.sections = sections
    }
}

