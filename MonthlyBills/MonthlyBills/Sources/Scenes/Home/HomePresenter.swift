//
//  HomePresenter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 26/11/23.
//

import Foundation
import SharpnezCore
import SharpnezDesignSystem

protocol HomePresenting {
    func presentSuccess(calendars: [AnnualCalendarViewModel])
    func presentError(error: Error)
}

final class HomePresenter: UIVIPPresenter<HomeViewControlling>, HomePresenting {
    
    // MARK: Methods
    
    func presentSuccess(calendars: [AnnualCalendarViewModel]) {
        if calendars.isEmpty {
            viewController?.presentEmpty()
            return
        }
        
        viewController?.presentSuccess(calendars: calendars)
    }
    
    func presentError(error: Error) {
        viewController?.presentError(message: (error as? CoreError)?.message)
    }
}
