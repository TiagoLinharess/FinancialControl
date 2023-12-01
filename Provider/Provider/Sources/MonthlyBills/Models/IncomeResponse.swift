//
//  IncomeResponse.swift
//  Provider
//
//  Created by Tiago Linhares on 30/11/23.
//

import Foundation

public struct IncomeResponse: Codable {
    
    // MARK: Properties
    
    public let salary: Double
    public let bonus: Double
    public let extra: Double
    public let other: Double
    
    // MARK: Init
    
    public init(salary: Double, bonus: Double, extra: Double, other: Double) {
        self.salary = salary
        self.bonus = bonus
        self.extra = extra
        self.other = other
    }
}
