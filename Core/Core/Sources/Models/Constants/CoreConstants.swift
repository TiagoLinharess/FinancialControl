//
//  CoreConstants.swift
//  Core
//
//  Created by Tiago Linhares on 30/11/23.
//

import Foundation

public enum CoreConstants {
    
    // MARK: Commons
    
    public enum Commons {
        public static let bills: String = "Bills"
        public static let weekly: String = "Weekly"
        public static let budgets: String = "Budgets"
        public static let pickerSelect: String = "select"
        public static let AlertTitle: String = "Message"
        public static let edit: String = "Edit"
        public static let ok: String = "ok"
        public static let create: String = "Create"
        public static let cash: String = "$%@"
        public static let key: String = "%@:"
        public static let incomesKey: String = "Incomes"
        public static let salaryKey: String = "Salary"
        public static let bonusKey: String = "Bonus"
        public static let extraKey: String = "Extra"
        public static let otherKey: String = "Other"
        public static let investmentsKey: String = "Investments"
        public static let sharesKey: String = "Shares"
        public static let privatePensionKey: String = "Private pension"
        public static let fixedIncomeKey: String = "Fixed income"
        public static let expensesKey: String = "Expenses"
        public static let housingKey: String = "Housing"
        public static let transportKey: String = "Transport"
        public static let feedKey: String = "Feed"
        public static let healthKey: String = "Health"
        public static let educationKey: String = "Education"
        public static let taxesKey: String = "Taxes"
        public static let laisureKey: String = "Laisure"
        public static let clothingKey: String = "Clothing"
        public static let creditCardKey: String = "Credit card"
        public static let total: String = "Total"
        public static let tryAgain: String = "Try again"
        public static let defaultErrorMessage: String = "Something went wrong, please try again later"
        public static let currencyPlaceholder: String = Double.zero.toCurrency()
        public static let emptyTitle: String = "There is nothing yet"
    }
    
    // MARK: Init
    
    public enum Init {
        public static let coder: String = "init(coder:) has not been implemented"
    }
    
    // MARK: Error
    
    public enum Error {
        public static let indexOutOfBounds: String = "index out of bounds"
        public static let generic: String = "Something happened, try again later"
    }
    
    // MARK: Icons
    
    public enum Icons {
        public static let calendar: String = "calendar"
        public static let close: String = "xmark"
        public static let check: String = "checkmark"
        public static let cash: String = "dollarsign"
        public static let creditCard: String = "creditcard"
        public static let add: String = "plus"
        public static let week: String = "calendar.day.timeline.left"
    }
    
    // MARK: Sizes
    
    public enum Sizes {
        public static let pickerHeight: CGFloat = 140
    }
}
