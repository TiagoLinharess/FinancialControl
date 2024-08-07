//
//  AddAnnualCalendarInteractor.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 27/11/23.
//

import Core
import Foundation
import SharpnezCore
import SharpnezDesignSystem

protocol AddAnnualCalendarInteracting { 
    func fetchAvailableYears()
    func submit(year: String)
}

final class AddAnnualCalendarInteractor: UIVIPInteractor<AddAnnualCalendarPresenting>, AddAnnualCalendarInteracting {
    
    // MARK: Properties
    
    let worker: BillsWorking
    
    // MARK: Init
    
    init(presenter: AddAnnualCalendarPresenting, worker: BillsWorking = BillsWorker()) {
        self.worker = worker
        super.init(presenter: presenter)
    }
    
    // MARK: Methods
    
    func fetchAvailableYears() {
        let calendar = Calendar.current
        let years = [
            CoreConstants.Commons.pickerSelect,
            String(calendar.component(.year, from: calendar.date(byAdding: .year, value: 0, to: Date()) ?? Date())),
            String(calendar.component(.year, from: calendar.date(byAdding: .year, value: 1, to: Date()) ?? Date())),
            String(calendar.component(.year, from: calendar.date(byAdding: .year, value: 2, to: Date()) ?? Date()))
        ]
        
        presenter.setYears(years: years)
    }
    
    func submit(year: String) {
        guard !year.isEmpty, year != CoreConstants.Commons.pickerSelect else {
            presenter.presentError(error: CoreError.customError(Constants.AddAnnualCalendarView.errorMessage))
            return
        }
        
        do {
            try worker.createCalendar(annualCalendar: AnnualCalendarViewModel(year: year))
            presenter.presentSuccess()
        } catch {
            presenter.presentError(error: error)
        }
    }
}
