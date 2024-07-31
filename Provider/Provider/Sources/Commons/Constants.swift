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
    
    // MARK: MonthlyBillsProvider
    
    enum MonthlyBillsRepository {
        static let existentCalendar: String = "Calendar already been added"
        static let calendarNotFound: String = "Could not find calendar"
        static let billNotFound: String = "Could not find bill"
        static let itemNotFound: String = "Could not find item"
        static let existentItem: String = "item already been added"
        static let templateNotFound: String = "Template not found"
    }
    
    // MARK: Login
    
    enum Login {
        static let reason: String = "Account access"
        static let incompletePassword: String = "Please, insert a password with more then 3 numbers"
        static let passwordExists: String = "Password Exists"
        static let incorrectPassword: String = "Incorrect Password"
        static let sessionQueryKey: String = "financial_control_login_session_key"
        static let authTypeQueryKey: String = "financial_control_login_auth_type_key"
        static let passwordQueryKey: String = "financial_control_login_password_key"
    }
}
