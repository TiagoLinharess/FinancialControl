//
//  
//  ConfigurationViewController.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 07/06/24.
//
//

import SharpnezDesignSystem
import Core
import UIKit

protocol ConfigurationViewControlling { }

final class ConfigurationViewController: UIVIPBaseViewController<ConfigurationView, ConfigurationInteracting, ConfigurationRouting> {
    
    // MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        title = CoreConstants.Commons.configurations
        
        let closeButton = UIBarButtonItem(
            image: UIImage(systemName: CoreConstants.Icons.close),
            primaryAction: UIAction(handler: { _ in self.close() })
        )
        
        navigationItem.leftBarButtonItems = [closeButton]
    }
    
    func close() {
        router.close(animated: true)
    }
}

extension ConfigurationViewController: ConfigurationViewDelegate {
    
    // MARK: ConfigurationViewDelegate
    
    func didSelect(configuration: Configurations) {
        router.goToConfiguration(configuration: configuration, animated: true)
    }
}

extension ConfigurationViewController: ConfigurationViewControlling { }
