//
//  
//  CalendarDetailInteractor.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 01/12/23.
//
//

import Foundation
import SharpnezDesignSystem

protocol CalendarDetailInteracting { 
    func update(calendar: AnnualCalendarViewModel)
}

final class CalendarDetailInteractor: UIVIPInteractor<CalendarDetailPresenting>, CalendarDetailInteracting {
    
    private let worker: BillsWorking
    
    init(presenter: CalendarDetailPresenting, worker: BillsWorking = BillsWorker()) {
        self.worker = worker
        super.init(presenter: presenter)
    }
    
    // MARK: Methods
    
    func update(calendar: AnnualCalendarViewModel) {
        do {
            let updatedCalendar = try worker.readAt(year: calendar.year)
            presenter.presentSuccess(newCalendar: updatedCalendar)
        } catch {
            presenter.presentError(error: error)
        }
    }
}
