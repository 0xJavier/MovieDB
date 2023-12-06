//
//  SectionHeader.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/25/22.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeader"
    
    let titleLabel: UILabel = .build { label in
        label.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: 22, weight: .bold))
        label.textColor = .label
    }
    
    let stackView: UIStackView = .build { view in
        view.axis = .vertical
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stackView.addArrangedSubview(titleLabel)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
