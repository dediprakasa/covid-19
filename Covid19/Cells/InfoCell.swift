//
//  InfoCell.swift
//  Covid19
//
//  Created by Dedi Prakasa on 5/10/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

enum InfoType {
    case overview, symptoms, prevention, qna
}

class InfoCell: UICollectionViewCell {
    
    static let reuseID = "info"
    
    let imageView = UIImageView()
        let label = UILabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func set(type: InfoType) {
        switch type {
        case .overview:
            label.text = "Overview"
            imageView.image = UIImage(named: "ov")
        case .symptoms:
            label.text = "Symptoms"
            imageView.image = UIImage(named: "symptoms")
        case .prevention:
            label.text = "Prevention"
            imageView.image = UIImage(named: "prevent")
        case .qna:
            label.text = "Q&A"
            imageView.image = UIImage(named: "qna")
        }
//        configure()
    }
    
    func configure() {
        
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        layer.cornerRadius = 10
        
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFill
//        imageView.backgroundColor = .systemRed
        imageView.translatesAutoresizingMaskIntoConstraints = false

        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 95),
            imageView.widthAnchor.constraint(equalToConstant: 95)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
