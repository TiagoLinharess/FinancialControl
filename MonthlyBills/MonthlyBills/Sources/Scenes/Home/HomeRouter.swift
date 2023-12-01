//
//  HomeRouter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 26/11/23.
//

import Foundation
import SharpnezDesignSystem

protocol HomeRouting {
    func routeToAdd(delegate: AddBillDelegate)
}

final class HomeRouter: UIVIPRouter, HomeRouting {
    
    // MARK: Methods
    
    func routeToAdd(delegate: AddBillDelegate) {
        let addAnnualCalendarController = AddAnnualCalendarFactory.configure(delegate: delegate)
        viewController?.navigationController?.present(addAnnualCalendarController, animated: true)
    }
}
