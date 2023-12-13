//
//  ExtractViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 12/12/23.
//

import Core
import Foundation

struct ExtractViewModel {
    
    // MARK: Properties
    
    let title: String
    private(set) var rows: [RowViewModel]
    
    // MARK: Init
    
    init(title: String, rows: [RowViewModel], percentage: Double? = nil) {
        self.title = title
        self.rows = rows
        
        if let percentage {
            self.rows.append(RowViewModel(title: CoreConstants.Commons.percentage, value: percentage))
        }
    }
}
