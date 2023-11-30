//
//  HomeRouter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 26/11/23.
//

import Foundation
import SharpnezDesignSystem

protocol HomeRouting {
    func routeToAdd()
}

final class HomeRouter: UIVIPRouter, HomeRouting {
    
    // MARK: Methods
    
    func routeToAdd() {
        let addAnnualCalendarController = AddAnnualCalendarFactory.configure()
        viewController?.navigationController?.present(addAnnualCalendarController, animated: true)
    }
}
