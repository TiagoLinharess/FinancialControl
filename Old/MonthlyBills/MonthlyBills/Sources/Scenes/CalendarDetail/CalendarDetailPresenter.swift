//
//  
//  CalendarDetailPresenter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 01/12/23.
//
//

import Foundation
import SharpnezCore
import SharpnezDesignSystem

protocol CalendarDetailPresenting {
    func presentSuccess(newCalendar: AnnualCalendarViewModel)
    func presentError(error: Error)
}

final class CalendarDetailPresenter: UIVIPPresenter<CalendarDetailViewControlling>, CalendarDetailPresenting {
    
    // MARK: Methods
    
    func presentSuccess(newCalendar: AnnualCalendarViewModel) {
        viewController?.presentSuccess(newCalendar: newCalendar)
    }
    
    func presentError(error: Error) {
        viewController?.presentError(message: (error as? CoreError)?.message ?? CoreError.genericError.message)
    }
}
