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
    func routeToDetail(year: String)
    func routeToTemplate()
}

final class HomeRouter: UIVIPRouter, HomeRouting {
    
    // MARK: Methods
    
    func routeToAdd(delegate: AddBillDelegate) {
        let controller = AddAnnualCalendarFactory.configure(delegate: delegate)
        viewController?.navigationController?.present(controller, animated: true)
    }
    
    func routeToDetail(year: String) {
        let controller = CalendarDetailFactory.configure(year: year)
        viewController?.navigationController?.present(controller, animated: true)
    }
    
    func routeToTemplate() {
        let controller = TemplateFormFactory.configure()
        viewController?.navigationController?.present(controller, animated: true)
    }
}
