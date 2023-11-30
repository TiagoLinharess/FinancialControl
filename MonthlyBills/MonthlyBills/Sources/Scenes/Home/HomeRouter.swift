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
    
    func routeToAdd() {
        let addAnnualBillController = AddAnnualBillFactory.configure()
        viewController?.navigationController?.present(addAnnualBillController, animated: true)
    }
}
