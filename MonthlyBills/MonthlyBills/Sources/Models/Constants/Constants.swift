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
        static let zeroIncomePercentage: String = "100%"
        static let totalPayed: String = "Total payed"
        static let totalPending: String = "Total pending"
    }
    
    enum BillItemFormView {
        static let fieldsError: String = "Please, fill all fields corretly"
        static let installmentError: String = "Please, use installment corretly"
        static let billTypeTitle: String = "bill type*"
        static let paymentStatusTitle: String = "payment status*"
        static let nameTitle: String = "name*"
        static let namePlaceholder: String = "EX: Food"
        static let valueSwitchTitle: String = "implements value"
        static let valuePlaceholder: String = "value*"
        static let installmentSwitchTitle: String = "implements installment"
        static let installmentCurrentTitle: String = "current*"
        static let installmentCurrentPlaceholder: String = "EX: 10"
        static let installmentMaxTitle: String = "EX: 10"
        static let installmentMaxPlaceholder: String = "EX: 12"
        
    }
    
    enum TemplateFormView {
        static let reuseIdentifier: String = "TemplateIdentifier"
    }
}
