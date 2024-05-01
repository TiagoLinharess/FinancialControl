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
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        verifySession()
    }
    
    // MARK: Configure
    
    private func configure() {
        let billsController = TabBarFactory.getMonthlyBillsController()
        let budgetsController = TabBarFactory.getWeeklyBudgetsController()
        
        viewControllers = [budgetsController, billsController]
    }
    
    // MARK: Session
    
    private func verifySession() {
        let loginFacade = LoginFacade(navigationController: navigationController ?? UINavigationController())
        
        loginFacade.start { [weak self] result in
            switch result {
            case .success:
                self?.navigationController?.popViewController(animated: true)
            case let .failure(failure):
                print(failure)
            }
        }
    }
}
