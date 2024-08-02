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
        static let templateWraning: String = "You already have bills implemented, if you download the templates, the current bills will be deleted to implement your template, are you sure?"
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
        static let title: String = "Template"
        static let subTitle: String = "Here you can create your bills template"
        static let description: String = "For example, when creating a template for fixed bills with a fixed or variable value, this can help you always remember to pay and fill them in a simpler and faster way"
    }
    
    enum Configurations {
        static let reuseIdentifier: String = "ConfigurationIdentifier"
        static let templates: String = "Templates"
        static let billType: String = "Bill Types"
    }
    
    enum BilltypesList {
        static let reuseIdentifier: String = "BillTypesIdentifier"
        static let title: String = "Bill Types"
        static let add: String = "Add Bill Type"
        static let incomes: String = "Incomes"
        static let listTips: String = "You can drag and drop all itens in this list."
    }
}
