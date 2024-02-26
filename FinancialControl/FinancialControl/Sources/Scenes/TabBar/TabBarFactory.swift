//
//  TabBarFactory.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 10/11/23.
//

import Core
import MonthlyBills
import UIKit
import WeeklyBudgets

enum TabBarFactory {
    
    // MARK: Configure
    
    static func configure() -> UITabBarController {
        let tabBar = UITabBarController()
        
        let billsController = getMonthlyBillsController()
        let budgetsController = getWeeklyBudgetsController()
        
        tabBar.viewControllers = [budgetsController, billsController]
        
        return tabBar
    }
    
    // MARK: Bills
    
    static private func getMonthlyBillsController() -> UIViewController {
        let billsController = UINavigationController(rootViewController: MBFacade().start())
        billsController.tabBarItem = UITabBarItem(
            title: CoreConstants.Commons.bills,
            image: UIImage(systemName: CoreConstants.Icons.calendar),
            selectedImage: UIImage(systemName: CoreConstants.Icons.calendar)
        )
        
        return billsController
    }
    
    // MARK: Budgets
    
    static private func getWeeklyBudgetsController() -> UIViewController {
        let weeklyBudgetsController = WBFacade().start()
        weeklyBudgetsController.tabBarItem = UITabBarItem(
            title: CoreConstants.Commons.budgets,
            image: UIImage(systemName: CoreConstants.Icons.week),
            selectedImage: UIImage(systemName: CoreConstants.Icons.week)
        )
        
        return weeklyBudgetsController
    }
}
