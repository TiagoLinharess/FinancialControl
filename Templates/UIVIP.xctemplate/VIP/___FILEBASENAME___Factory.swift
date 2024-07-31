//
//  ___FILEHEADER___
//

import UIKit

enum ___VARIABLE_productName:identifier___Factory {
    
    static func configure() -> UIViewController {
        let router = ___VARIABLE_productName:identifier___Router()
        let presenter = ___VARIABLE_productName:identifier___Presenter()
        let interactor = ___VARIABLE_productName:identifier___Interactor(presenter: presenter)
        let view = ___VARIABLE_productName:identifier___View()
        
        let controller = ___VARIABLE_productName:identifier___ViewController(customView: view, interactor: interactor, router: router)
        
        router.viewController = controller
        presenter.viewController = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
