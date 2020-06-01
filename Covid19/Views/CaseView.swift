//
//  CaseView.swift
//  Covid19
//
//  Created by Dedi Prakasa on 5/4/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class CaseView: UIView {
    
    enum Category {
        case confirmed, recovered, death
    }
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(category: Category) {
        super.init(frame: .zero)
        
        switch category {
        case .confirmed:
            categoryLabel.text = "Confirmed"
            categoryLabel.textColor = .systemOrange
            valueLabel.textColor = .systemOrange
        case .recovered:
            categoryLabel.text = "Recovered"
            categoryLabel.textColor = .systemGreen
            valueLabel.textColor = .systemGreen
        case .death:
            categoryLabel.text = "Death"
            categoryLabel.textColor = .systemRed
            valueLabel.textColor = .systemRed
        }
        
        
        
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        layer.cornerRadius = 10

        translatesAutoresizingMaskIntoConstraints = false
        
        configure()
    }
    
    func configure() {
        addSubview(categoryLabel)
        addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            categoryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            valueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(numberOfCase: Int) {
        self.valueLabel.text = String(numberOfCase)
    }
    
}
