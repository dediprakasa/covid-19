//
//  InfoView.swift
//  Covid19
//
//  Created by Dedi Prakasa on 5/9/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

//enum InfoType {
//    case overview, symptoms, prevention, qna
//}

//class InfoView: UIView {
//    
//    let imageView = UIImageView()
//    let label = UILabel()
//    let gesture = UITapGestureRecognizer(target: self, action: #selector(showInfo))
//
//    @objc func showInfo(sender : UITapGestureRecognizer) {
//        print("YAA")
//    }
////    override init(frame: CGRect) {
////        super.init(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 150))
////        configure()
////    }
//    
//    init(type: InfoType) {
//        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 150))
//        switch type {
//        case .overview:
//            label.text = "Overview"
//            imageView.image = UIImage(named: "ov")
//        case .symptoms:
//            label.text = "Symptoms"
//            imageView.image = UIImage(named: "symptoms")
//        case .prevention:
//            label.text = "Prevention"
//            imageView.image = UIImage(named: "prevent")
//        case .qna:
//            label.text = "Q&A"
//            imageView.image = UIImage(named: "qna")
//        }
//        configure()
//    }
//    
//    func configure() {
//        addGestureRecognizer(gesture)
//        
//        backgroundColor = .white
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.2
//        layer.shadowOffset = .zero
//        layer.shadowRadius = 5
//        layer.cornerRadius = 10
//        
//        label.font = UIFont.boldSystemFont(ofSize: 18)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        imageView.contentMode = .scaleAspectFill
////        imageView.backgroundColor = .systemRed
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//
//        translatesAutoresizingMaskIntoConstraints = false
//        
//        addSubview(label)
//        addSubview(imageView)
//        
//        NSLayoutConstraint.activate([
//            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            
//            
//            imageView.topAnchor.constraint(equalTo: self.topAnchor),
//            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
//            imageView.heightAnchor.constraint(equalToConstant: 95),
//            imageView.widthAnchor.constraint(equalToConstant: 95)
//        ])
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//}
