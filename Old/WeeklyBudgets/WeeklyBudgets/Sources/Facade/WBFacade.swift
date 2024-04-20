//
//  WBFacade.swift
//  WeeklyBudgets
//
//  Created by Tiago Linhares on 10/11/23.
//

import UIKit

public final class WBFacade {
    
    public init() { }
    
    public func start() -> UIViewController {
        return WeeklyBudgetsHomeHostingController(rootView: .init(viewModel: .init()))
    }
}
