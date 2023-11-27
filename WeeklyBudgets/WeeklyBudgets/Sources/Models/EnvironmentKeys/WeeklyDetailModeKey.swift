//
//  WeeklyDetailModeKey.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 29/10/23.
//

import SwiftUI

// MARK: Environment Key

struct WeeklyDetailModeKey: EnvironmentKey {
    static let defaultValue = Binding<Bool>.constant(false)
}

// MARK: Set Environment Value

extension EnvironmentValues {
    var weeklyDetailMode: Binding<Bool> {
        get { return self[WeeklyDetailModeKey.self] }
        set { self[WeeklyDetailModeKey.self] = newValue }
    }
}
