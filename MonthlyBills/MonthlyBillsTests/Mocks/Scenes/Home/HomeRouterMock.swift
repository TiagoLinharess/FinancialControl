//
//  HomeRouterMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 12/01/24.
//

@testable import MonthlyBills
import SharpnezCore
import XCTest

final class HomeRouterMock: HomeRouting {
    
    var didRouteToAdd = false
    var didRouteToDetail = false
    
    func routeToAdd(delegate: MonthlyBills.AddBillDelegate) {
        didRouteToAdd = true
    }
    
    func routeToDetail(year: String) {
        didRouteToDetail = true
    }
}
