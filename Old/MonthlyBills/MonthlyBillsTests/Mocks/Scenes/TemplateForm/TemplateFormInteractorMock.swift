//
//  TemplateFormInteractorMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 22/02/24.
//

@testable import MonthlyBills
import Foundation

final class TemplateFormInteractorMock: TemplateFormInteracting {
    var didFetch: Bool = false
    var didDelete: Bool = false
    
    func fetch() {
        didFetch = true
    }
    
    func delete(at id: String) {
        didDelete = true
    }
}
