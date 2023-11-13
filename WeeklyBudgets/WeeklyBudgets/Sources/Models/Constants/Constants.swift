//
//  Constants.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import Foundation

enum Constants {
    
    // MARK: Commons
    
    enum Commons {
        static let weekly: String = "Weekly"
        static let pickerSelect: String = "select"
        static let AlertTitle: String = "Message"
        static let ok: String = "ok"
        static let create: String = "Create"
        static let cash: String = "$%@"
        static let tryAgain: String = "Try again"
        static let defaultErrorMessage: String = "Something went wrong, please try again later"
        static let currencyPlaceholder: String = Double.zero.toCurrency()
    }
    
    // MARK: Icons
    
    enum Icons {
        static let monthlyCalendar: String = "calendar"
        static let close: String = "xmark"
        static let check: String = "checkmark"
        static let cash: String = "dollarsign"
        static let creditCard: String = "creditcard"
        static let add: String = "plus"
    }
    
    // MARK: WeeklyHome
    
    enum WeeklyHome {
        static let title: String = "Weekly Budgets"
        static let emptyTitle: String = "There is nothing yet"
    }
    
    // MARK: WeeklyBudgetStartView
    
    enum AddWeeklyBudgetStart {
        static let title: String = "Add Budget"
        static let singleWeekTitle: String = "One week"
        static let singleWeekDescription: String = "Add budget for only a single week"
    }
    
    // MARK: SingleWeekForm
    
    enum SingleWeekForm {
        static let title: String = "Single week"
        static let pickerTitle: String = "Select a week"
        static let budgetPlaceholder: String = "Week budget"
        static let creditCardPlaceholder: String = "Credit card week limit"
        
        static let selectWeekError: String = "Please, select a week to continue."
        static let fillAllFieldsCorrectly: String = "Please, fill all fields correctly to continue."
    }
    
    // MARK: WeeklyReviewView
    
    enum WeeklyReview {
        static let title: String = "Review"
        static let successMessage: String = "Budgets added with success"
    }
    
    // MARK: WeeklyBudgetDetailView
    
    enum WeeklyBudgetDetailView {
        static let original: String = "Original"
        static let current: String = "Current"
        static let limit: String = "Limit"
        static let remainingLimit: String = "Remaining"
        static let expenses: String = "Expenses"
        static let addExpense: String = "Add expense"
        static let editBudget: String = "Edit budget"
    }
    
    // MARK: AddWeeklyExpenseView
    
    enum AddWeeklyExpenseView {
        static let title = "Title*"
        static let titlePlaceholder = "Iphone 15 Pro"
        static let description = "Description"
        static let descriptionPlaceholder = "Purchased from the Apple store"
        static let selectPaymentMode = "Select payment mode*"
        static let paymentMode = "Payment mode"
        static let value = "Value*"
        static let successMessage: String = "Expense added with success"
    }
    
    // MARK: WeekBudgetView
    
    enum WeekBudgetView {
        static let weekTitle: String = "Week"
        static let budgetTitle: String = "Budget"
        static let creditCardTitle: String = "Credit"
    }
}
