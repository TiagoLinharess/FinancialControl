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
    
    static func configure(calendar: AnnualCalendarViewModel) -> UIViewController {
        let router = CalendarDetailRouter()
        let presenter = CalendarDetailPresenter()
        let interactor = CalendarDetailInteractor(presenter: presenter)
        let view = CalendarDetailView()
        
        let controller = CalendarDetailViewController(
            calendar: calendar,
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
