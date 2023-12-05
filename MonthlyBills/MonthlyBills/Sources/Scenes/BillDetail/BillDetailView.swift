//
//  BillDetailView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 05/12/23.
//

import SharpnezDesignSystem
import SnapKit
import UIKit

final class BillDetailView: UIView {
    
    // MARK: Properties
    
    var delegate: BillDetailViewControllerDelegate? {
        didSet {
            configure()
        }
    }
    
    // MARK: UI Elements
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.backgroundColor = .clear
        scrollView.isUserInteractionEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var incomeTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.text = "Incomes"
        label.font = .systemFont(ofSize: .big, weight: .bold)
        return label
    }()
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension BillDetailView: UIViewCode {
    
    // MARK: View Setup
    
    func configure() {
        guard let bill = delegate?.getBill() else { return }
    }
    
    func setupView() {
        backgroundColor = .systemBackground
        configure()
    }
    
    func setupHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(incomeTitle)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        incomeTitle.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(CGFloat.small)
            $0.trailing.equalToSuperview().inset(CGFloat.small)
        }
    }
}

extension BillDetailView: UIScrollViewDelegate {
    
    // MARK: UIScrollView Delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
}
