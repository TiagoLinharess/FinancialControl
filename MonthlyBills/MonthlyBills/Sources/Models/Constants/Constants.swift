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
    
    // MARK: AddAnnualBillView
    
    enum AddAnnualBillView {
        static let title: String = "Add Annual Bills"
        static let mainLabel: String = "Select the year to create the annual bills calendar."
        static let successMessage: String = "annual bill added with success"
        static let errorMessage: String = "please, select a year to continue"
    }
}
