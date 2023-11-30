//
//  HomeFactory.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 26/11/23.
//

import UIKit

enum HomeFactory {
    
    static func configure() -> UIViewController {
        let router = HomeRouter()
        let presenter = HomePresenter()
        let interactor = HomeInteractor(presenter: presenter)
        let view = HomeView()
        
        let controller = HomeViewController(customView: view, interactor: interactor, router: router)
        
        router.viewController = controller
        presenter.viewController = controller
        
        return controller
    }
}
