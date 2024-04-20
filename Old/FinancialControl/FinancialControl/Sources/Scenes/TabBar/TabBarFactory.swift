//
//  TabBarFactory.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 10/11/23.
//

import Core
import MonthlyBills
import UIKit

enum TabBarFactory {
    
    // MARK: Configure
    
    static func configure() -> UIViewController {
        return UINavigationController(rootViewController: MBFacade().start())
    }
}
