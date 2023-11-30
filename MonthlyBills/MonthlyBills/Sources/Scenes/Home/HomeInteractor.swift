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
    func fetchBills()
}

final class HomeInteractor: UIVIPInteractor<HomePresenting>, HomeInteracting {
    
    // MARK: Methods
    
    func fetchBills() {
        let bills: [AnnualBillsViewModel] = [.init(year: "2023"), .init(year: "2024"), .init(year: "2025")]
        presenter.presentSuccess(bills: bills)
    }
}
