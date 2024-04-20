//
//  WeeklyModalModeKey.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 31/08/23.
//

import SwiftUI

// MARK: Environment Key

struct WeeklyModalModeKey: EnvironmentKey {
    static let defaultValue = Binding<Bool>.constant(false)
}

// MARK: Set Environment Value

extension EnvironmentValues {
    var weeklyModalMode: Binding<Bool> {
        get { return self[WeeklyModalModeKey.self] }
        set { self[WeeklyModalModeKey.self] = newValue }
    }
}
