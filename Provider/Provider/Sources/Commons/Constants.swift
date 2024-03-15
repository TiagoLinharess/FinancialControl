//
//  Constants.swift
//  Provider
//
//  Created by Tiago Linhares on 13/11/23.
//

import Foundation

enum Constants {
    
    // MARK: Entity
    
    enum Entity {
        static let model: String = "ProviderModel"
        static let modelExtension: String = "momd"
        static let calendar: String = "AnnualCalendarEntity"
        static let bill: String = "MonthlyBillsEntity"
    }
    
    // MARK: User Defaults Keys
    
    enum UserDefaultsKeys {
        static let weekly: String = "WeeklyBudgetsKey"
        static let bills: String = "MonthlyBillsKey"
        static let billsTemplate: String = "MonthlyBillsTemplateKey"
    }
    
    // MARK: WeeklyBudgetsRepository
    
    enum WeeklyBudgetsRepository {
        static let existentWeek: String = "This week has already been added"
        static let weekDoesNotExist: String = "The item you are editing does not exist"
    }
    
    // MARK: MonthlyBillsRepository
    
    enum MonthlyBillsRepository {
        static let existentCalendar: String = "Calendar already been added"
        static let calendarNotFound: String = "Could not find calendar"
        static let billNotFound: String = "Could not find bill"
        static let itemNotFound: String = "Could not find item"
        static let existentItem: String = "item already been added"
        static let templateNotFound: String = "Template not found"
    }
}
