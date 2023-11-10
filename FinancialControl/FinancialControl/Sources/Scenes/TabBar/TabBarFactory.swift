//
//  TabBarFactory.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 10/11/23.
//

import UIKit
import WeeklyBudgets

enum TabBarFactory {
    
    // MARK: Factory
    
    static func configure() -> UITabBarController {
        let tabBar = UITabBarController()
        
        let billsController = getMonthlyBillsController()
        let budgetsController = getWeeklyBudgetsController()
        
        tabBar.viewControllers = [budgetsController, billsController]
        
        return tabBar
    }
    
    static private func getMonthlyBillsController() -> UIViewController {
        let billsController = UINavigationController(rootViewController: ViewController())
        billsController.tabBarItem = UITabBarItem(title: "Bills", image: UIImage(systemName: "calendar"), selectedImage: UIImage(systemName: "calendar"))
        
        return billsController
    }
    
    static private func getWeeklyBudgetsController() -> UIViewController {
        let weeklyBudgetsController = WBFacade().start()
        weeklyBudgetsController.tabBarItem = UITabBarItem(title: "Budgets", image: UIImage(systemName: "calendar.day.timeline.left"), selectedImage: UIImage(systemName: "calendar.day.timeline.left"))
        
        return weeklyBudgetsController
    }
}
