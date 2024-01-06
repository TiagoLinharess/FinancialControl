//
//  NotesView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 04/01/24.
//

import SharpnezDesignSystem
import UIKit
import SnapKit

final class UINotesView: UIView {
    
    // MARK: UI Elements
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = .zero
        return label
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = .init(top: .smaller, left: .small, bottom: .zero, right: .zero)
        textView.font = .systemFont(ofSize: 16)
        textView.allowsEditingTextAttributes = true
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = .smaller
        return textView
    }()
    
    // MARK: Init
    
    init(title: String) {
        super.init(frame: .zero)
        setup()
        titleLabel.text = title.uppercased()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension UINotesView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .clear
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(textView)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(CGFloat.small)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.nano)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(120)
        }
    }
}
