//
//  CalendarDetailInteractorMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 25/02/24.
//

@testable import MonthlyBills
import Foundation

final class CalendarDetailInteractorMock: CalendarDetailInteracting {
    var didUpdate: Bool = false
    
    func update(at year: String) {
        didUpdate = true
    }
}
