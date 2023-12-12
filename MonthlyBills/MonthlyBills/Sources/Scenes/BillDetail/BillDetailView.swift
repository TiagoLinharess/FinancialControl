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
    
    private lazy var incomesView: ExtractView = {
        let view = ExtractView()
        view.didTapEdit = delegate?.navigateToIncomes
        return view
    }()
    
    private lazy var investimentsView: ExtractView = {
        let view = ExtractView()
        view.didTapEdit = delegate?.navigateToInvestments
        return view
    }()
    
    private lazy var expensesView: ExtractView = {
        let view = ExtractView()
        view.didTapEdit = delegate?.navigateToExpenses
        return view
    }()
    
    private lazy var balanceKeyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.text = "Balance:"
        label.font = .systemFont(ofSize: .big, weight: .semibold)
        return label
    }()
    
    private lazy var balanceValueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: .big, weight: .semibold)
        return label
    }()
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        setup()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Public Methods
    
    func configure() {
        configureIncomes()
        configureInvestiments()
        configureExpenses()
        configureBalance()
    }
}

extension BillDetailView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .systemBackground
    }
    
    func setupHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(incomesView)
        scrollView.addSubview(investimentsView)
        scrollView.addSubview(expensesView)
        scrollView.addSubview(balanceKeyLabel)
        scrollView.addSubview(balanceValueLabel)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        incomesView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(CGFloat.small)
            $0.width.equalTo(UIScreen.main.bounds.width - 32)
        }
        
        investimentsView.snp.makeConstraints {
            $0.top.equalTo(incomesView.snp.bottom).offset(CGFloat.medium)
            $0.leading.trailing.equalToSuperview().inset(CGFloat.small)
            $0.width.equalTo(UIScreen.main.bounds.width - 32)
        }
        
        expensesView.snp.makeConstraints {
            $0.top.equalTo(investimentsView.snp.bottom).offset(CGFloat.medium)
            $0.leading.trailing.equalToSuperview().inset(CGFloat.small)
            $0.width.equalTo(UIScreen.main.bounds.width - 32)
        }
        
        balanceKeyLabel.snp.makeConstraints {
            $0.top.equalTo(expensesView.snp.bottom).offset(CGFloat.small)
            $0.bottom.leading.equalToSuperview().inset(CGFloat.small)
            $0.trailing.lessThanOrEqualTo(balanceValueLabel.snp.leading).inset(CGFloat.small)
        }
        
        balanceValueLabel.snp.makeConstraints {
            $0.top.equalTo(expensesView.snp.bottom).offset(CGFloat.small)
            $0.bottom.trailing.equalToSuperview().inset(CGFloat.small)
            $0.leading.greaterThanOrEqualTo(balanceKeyLabel.snp.trailing).inset(CGFloat.small)
        }
    }
}

private extension BillDetailView {
    
    // MARK: Configure
    
    func configureIncomes() {
        guard let bill = delegate?.getBill() else { return }
        
        incomesView.configure(
            viewModel: ExtractViewModel(
                title: "Incomes",
                rows: [
                    .init(title: "Salary", value: bill.income?.salary),
                    .init(title: "Bonus", value: bill.income?.bonus),
                    .init(title: "Extra", value: bill.income?.extra),
                    .init(title: "Other", value: bill.income?.other),
                    .init(title: "Total", value: bill.income?.total),
                ]
            )
        )
    }
    
    func configureInvestiments() {
        guard let bill = delegate?.getBill() else { return }
        
        investimentsView.configure(
            viewModel: ExtractViewModel(
                title: "Investments",
                rows: [
                    .init(title: "Shares", value: bill.investment?.shares),
                    .init(title: "Private pension", value: bill.investment?.privatePension),
                    .init(title: "Fixed income", value: bill.investment?.fixedIncome),
                    .init(title: "Other", value: bill.investment?.other),
                    .init(title: "Total", value: bill.investment?.total),
                ]
            )
        )
    }
    
    func configureExpenses() {
        guard let bill = delegate?.getBill() else { return }
        
        expensesView.configure(
            viewModel: ExtractViewModel(
                title: "Expenses",
                rows: [
                    .init(title: "Housing", value: bill.expense?.housing),
                    .init(title: "Transport", value: bill.expense?.transport),
                    .init(title: "Feed", value: bill.expense?.feed),
                    .init(title: "Health", value: bill.expense?.health),
                    .init(title: "Education", value: bill.expense?.education),
                    .init(title: "Taxes", value: bill.expense?.taxes),
                    .init(title: "Laisure", value: bill.expense?.laisure),
                    .init(title: "Clothing", value: bill.expense?.clothing),
                    .init(title: "Credit card", value: bill.expense?.creditCard),
                    .init(title: "Other", value: bill.expense?.other),
                    .init(title: "Total", value: bill.expense?.total),
                ]
            )
        )
    }
    
    func configureBalance() {
        guard let bill = delegate?.getBill() else { return }
        balanceValueLabel.text = bill.balance.toCurrency()
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
