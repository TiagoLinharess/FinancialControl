//
//  Constants.swift
//  Provider
//
//  Created by Tiago Linhares on 13/11/23.
//

import Foundation

enum Constants {
    
    // MARK: User Defaults Keys
    
    enum UserDefaultsKeys {
        static let weekly: String = "WeeklyBudgetsKey"
        static let bills: String = "MonthlyBillsKey"
    }
    
    // MARK: WeeklyBudgetsRepository
    
    enum WeeklyBudgetsRepository {
        static let existentWeek: String = "This week has already been added"
        static let weekDoesNotExist: String = "The item you are editing does not exist"
    }
    
    // MARK: MonthlyBillsRepository
    
    enum MonthlyBillsRepository {
        static let existentCalendar: String = "Calendar already been added"
    }
}
