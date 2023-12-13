//
//  RowViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 12/12/23.
//

import Core
import Foundation

extension ExtractViewModel {
    
    struct RowViewModel {
        
        // MARK: Properties
        
        let title: String
        let value: String
        
        // MARK: Init
        
        init(title: String, value: Double?) {
            self.title = title
            
            let value = value ?? .zero
            self.value = title == CoreConstants.Commons.percentage 
            ? String(format: CoreConstants.Commons.percentageIcon, String(value))
            : value.toCurrency()
        }
    }
}

