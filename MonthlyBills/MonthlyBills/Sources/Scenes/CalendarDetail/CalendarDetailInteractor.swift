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
    func update(at year: String)
}

final class CalendarDetailInteractor: UIVIPInteractor<CalendarDetailPresenting>, CalendarDetailInteracting {
    
    // MARK: Properties
    
    private let worker: BillsWorking
    
    // MARK: Init
    
    init(presenter: CalendarDetailPresenting, worker: BillsWorking = BillsWorker()) {
        self.worker = worker
        super.init(presenter: presenter)
    }
    
    // MARK: Methods
    
    func update(at year: String) {
        do {
            let updatedCalendar = try worker.readAtYear(year: year)
            presenter.presentSuccess(newCalendar: updatedCalendar)
        } catch {
            presenter.presentError(error: error)
        }
    }
}
