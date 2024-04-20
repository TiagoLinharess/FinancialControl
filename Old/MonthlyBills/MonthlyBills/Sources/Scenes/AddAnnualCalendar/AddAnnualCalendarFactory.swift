//
//  AddAnnualCalendarFactory.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 27/11/23.
//

import UIKit

enum AddAnnualCalendarFactory {
    
    static func configure(delegate: AddBillDelegate?) -> UIViewController {
        let router = AddAnnualCalendarRouter()
        let presenter = AddAnnualCalendarPresenter()
        let interactor = AddAnnualCalendarInteractor(presenter: presenter)
        let view = AddAnnualCalendarView()
        
        let controller = AddAnnualCalendarViewController(customView: view, interactor: interactor, router: router)
        
        router.addBillDelegate = delegate
        router.viewController = controller
        presenter.viewController = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
