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
        static let monthly: String = "Monthly"
        static let weekly: String = "Weekly"
        static let addFinance: String = "Add finance"
    }
    
    // MARK: Icons
    
    enum Icons {
        static let monthlyCalendar: String = "calendar"
        static let weeklyCalendar: String = "calendar.day.timeline.left"
        static let pencil: String = "pencil"
        static let close: String = "xmark"
    }
    
    // MARK: WeeklyHome
    
    enum WeeklyHome {
        static let emptyTitle: String = "There is no weekly financies yet"
    }
    
    // MARK: WeeklyBudgetStartView
    
    enum AddWeeklyBudgetStart {
        static let title: String = "Add Budget"
        
        static let allMonthTitle: String = "All month"
        static let allMonthDescription: String = "Add budget for all weeks in the month"
        
        static let singleWeekTitle: String = "One week"
        static let singleWeekDescription: String = "Add budget for only a single week"
    }
    
    // MARK: SingleWeekForm
    
    enum SingleWeekForm {
        static let title: String = "Add Budget for single week"
    }
}
