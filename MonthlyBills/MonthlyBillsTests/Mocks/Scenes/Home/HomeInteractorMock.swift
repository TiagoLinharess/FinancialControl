//
//  HomeInteractorMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 12/01/24.
//

@testable import MonthlyBills
import SharpnezCore
import XCTest

final class HomeInteractorMock: HomeInteracting {
    
    var didFetchCalendars = false
    
    func fetchCalendars() {
        didFetchCalendars = true
    }
}
