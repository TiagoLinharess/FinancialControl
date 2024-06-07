//
//  
//  ConfigurationRouter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 07/06/24.
//
//

import SharpnezDesignSystem
import UIKit

protocol ConfigurationRouting {
    func close(animated: Bool)
    func goToConfiguration(configuration: Configurations, animated: Bool)
}

final class ConfigurationRouter: UIVIPRouter, ConfigurationRouting {
    
    // MARK: Methods
    
    func close(animated: Bool) {
        viewController?.navigationController?.dismiss(animated: animated)
    }
    
    func goToConfiguration(configuration: Configurations, animated: Bool) {
        viewController?.navigationController?.pushViewController(configuration.controller, animated: animated)
    }
}
