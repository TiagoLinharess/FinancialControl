//
//  BillItemFormViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 23/01/24.
//

import Foundation

struct BillItemFormViewModel {
    
    // MARK: Properties
    
    var formType: BillItemFormType?
    var billType: BillTypeViewModel?
    var status: BillStatus?
    var name: String?
    var validateTemplateValue: Bool
    var value: Double?
    var validateInstallment: Bool
    var installment: BillInstallment?
}
