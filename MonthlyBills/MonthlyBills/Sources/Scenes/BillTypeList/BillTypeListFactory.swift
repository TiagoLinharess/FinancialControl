//
//  
//  BillTypeListFactory.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 08/06/24.
//
//

import UIKit

enum BillTypeListFactory {
    
    static func configure() -> UIViewController {
        let router = BillTypeListRouter()
        let presenter = BillTypeListPresenter()
        let interactor = BillTypeListInteractor(presenter: presenter)
        let view = BillTypeListView()
        
        let controller = BillTypeListViewController(
            customView: view,
            interactor: interactor,
            router: router
        )
        
        router.viewController = controller
        presenter.viewController = controller
        
        return controller
    }
}
