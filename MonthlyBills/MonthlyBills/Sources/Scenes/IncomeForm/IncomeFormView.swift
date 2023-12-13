//
//  IncomeFormView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 12/12/23.
//

import SharpnezDesignSystem
import UIKit

final class IncomeFormView: UIView {
    
    // MARK: Properties
    
    
    
    // MARK: UI Elements
    
    
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension IncomeFormView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .systemBackground
    }
    
    func setupHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
}
