//
//  
//  CalendarDetailFactory.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 01/12/23.
//
//

import UIKit

enum CalendarDetailFactory {
    
    static func configure(year: String) -> UIViewController {
        let router = CalendarDetailRouter()
        let presenter = CalendarDetailPresenter()
        let interactor = CalendarDetailInteractor(presenter: presenter)
        let view = CalendarDetailView()
        
        let controller = CalendarDetailViewController(
            currentYear: year,
            customView: view,
            interactor: interactor,
            router: router
        )
        
        view.delegate = controller
        router.viewController = controller
        presenter.viewController = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
