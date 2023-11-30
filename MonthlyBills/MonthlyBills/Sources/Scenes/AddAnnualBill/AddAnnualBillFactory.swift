//
//  AddAnnualBillFactory.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 27/11/23.
//

import UIKit

enum AddAnnualBillFactory {
    
    static func configure() -> UIViewController {
        let router = AddAnnualBillRouter()
        let presenter = AddAnnualBillPresenter()
        let interactor = AddAnnualBillInteractor(presenter: presenter)
        let view = AddAnnualBillView()
        
        let controller = AddAnnualBillViewController(customView: view, interactor: interactor, router: router)
        
        router.viewController = controller
        presenter.viewController = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
