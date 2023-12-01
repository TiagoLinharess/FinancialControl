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
    func routeToDetail(calendar: AnnualCalendarViewModel)
}

final class HomeRouter: UIVIPRouter, HomeRouting {
    
    // MARK: Methods
    
    func routeToAdd(delegate: AddBillDelegate) {
        let controller = AddAnnualCalendarFactory.configure(delegate: delegate)
        viewController?.navigationController?.present(controller, animated: true)
    }
    
    func routeToDetail(calendar: AnnualCalendarViewModel) {
        let controller = CalendarDetailFactory.configure(calendar: calendar)
        viewController?.navigationController?.present(controller, animated: true)
    }
}
