//
//  HomeTabBarController.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/04/24.
//

import Login
import UIKit

final class HomeTabBarController: UITabBarController {
    
    // MARK: View Life Cicle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        configure()
        configureAppearance()
    }
    
    // MARK: Configure
    
    private func configure() {
        let billsController = TabBarFactory.getMonthlyBillsController()
        let budgetsController = TabBarFactory.getWeeklyBudgetsController()
        
        viewControllers = [budgetsController, billsController]
    }
    
    private func configureAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    // MARK: Session
    
    func verifySession() {
        let loginFacade = LoginFacade(navigationController: navigationController ?? UINavigationController())
        loginFacade.start()
    }
}
