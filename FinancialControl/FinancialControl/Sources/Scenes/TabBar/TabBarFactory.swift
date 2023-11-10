//
//  TabBarFactory.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 10/11/23.
//

import UIKit

enum TabBarFactory {
    
    // MARK: Factory
    
    static func configure() -> UITabBarController {
        let tabBar = UITabBarController()
        
        let billsController = UINavigationController(rootViewController: ViewController())
        billsController.tabBarItem = UITabBarItem(title: "Monthly", image: UIImage(systemName: "calendar"), selectedImage: UIImage(systemName: "calendar"))
        
        tabBar.viewControllers = [billsController]
        
        return tabBar
    }
}
