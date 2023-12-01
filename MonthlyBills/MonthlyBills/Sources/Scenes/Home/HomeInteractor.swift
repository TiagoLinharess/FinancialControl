//
//  HomeInteractor.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 26/11/23.
//

import Foundation
import SharpnezCore
import SharpnezDesignSystem

protocol HomeInteracting {
    func fetchCalendars()
}

final class HomeInteractor: UIVIPInteractor<HomePresenting>, HomeInteracting {
    
    // MARK: Properties
    
    let worker: BillsWorking
    
    // MARK: Init
    
    init(presenter: HomePresenting, worker: BillsWorking = BillsWorker()) {
        self.worker = worker
        super.init(presenter: presenter)
    }
    
    // MARK: Methods
    
    func fetchCalendars() {
        do {
            let calendars = try worker.read()
            presenter.presentSuccess(calendars: calendars)
        } catch {
            presenter.presentError(error: error)
        }
    }
}
