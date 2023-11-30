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
        public static let ok: String = "ok"
        public static let create: String = "Create"
        public static let cash: String = "$%@"
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
