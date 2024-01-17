//
//  Constants.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 30/11/23.
//

import Foundation

enum Constants {
    
    // MARK: HomeView
    
    enum HomeView {
        static let cellReuseIdentifier: String = "billCell"
    }
    
    // MARK: AddAnnualCalendarView
    
    enum AddAnnualCalendarView {
        static let title: String = "Add Annual Calendar"
        static let mainLabel: String = "Select the year to create the annual calendar."
        static let successMessage: String = "annual bill added with success"
        static let errorMessage: String = "please, select a year to continue"
    }
    
    // MARK: CalendarDetailView
    
    enum CalendarDetailView {
        static let title: String = "Calendar %@"
        static let reuseIdentifier: String = "CalendarDetailViewCellIdentifier"
    }
    
    enum BillDetailView {
        static let reuseIdentifier: String = "billDetailIdentifier"
        static let balanceKey: String = "Balance"
    }
    
    enum Form {
        static let successMessage: String = "%@ added with success."
    }
}
