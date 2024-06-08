//
//  Configurations.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 07/06/24.
//

import UIKit

enum Configurations: Int, CaseIterable {
    
    // MARK: Enums
    
    case templates
    case billTypes
    
    // MARK: Controller
    
    var controller: UIViewController {
        switch self {
        case .templates:
            return TemplateFormFactory.configure()
        case .billTypes:
            return BillTypeListFactory.configure()
        }
    }
    
    // MARK: Methods
    
    func getName() -> String {
        switch self {
        case .templates:
            return Constants.Configurations.templates
        case .billTypes:
            return Constants.Configurations.billType
        }
    }
}
