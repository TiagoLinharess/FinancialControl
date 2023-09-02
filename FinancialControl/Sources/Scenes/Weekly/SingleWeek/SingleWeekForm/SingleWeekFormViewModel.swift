//
//  SingleWeekFormViewModel.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 31/08/23.
//

import SwiftUI

protocol SingleWeekFormViewModelProtocol: ObservableObject {
    var creditCardLimit: String { get set }
    var weekSelected: String { get set }
    var weekBudget: String { get set }
    var weeks: [String] { get }
    func submit()
}

final class SingleWeekFormViewModel: SingleWeekFormViewModelProtocol {
    
    @Published var creditCardLimit: String = ""
    @Published var weekSelected: String = ""
    @Published var weekBudget: String = ""
    
    var weeks: [String] {
        var weeksDate: [Date] = []
        
        for i in 0..<12 {
            guard let month = Calendar.current.date(byAdding: .month, value: i, to: Date()) else { break }
            weeksDate.append(contentsOf: month.firstWeekDayOfMonth(with: 1))
        }
        
        let weeks = weeksDate.map{ date -> String in
            return "\(date.get(.day))/\(date.get(.month))/\(date.get(.year))"
        }
        
        return weeks
    }
    
    func submit() {
        
    }
}
