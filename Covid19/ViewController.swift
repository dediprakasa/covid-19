//
//  ViewController.swift
//  Covid19
//
//  Created by Dedi Prakasa on 5/4/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var response: MathdroidAPIResponse?
    
    let segmentedController: UISegmentedControl = {
        let items = ["My Country", "Global"]
        let sc = UISegmentedControl(items: items)
        sc.backgroundColor = .systemGray6
        sc.translatesAutoresizingMaskIntoConstraints = false
        
        return sc
    }()
    
    let confirmedView: CaseView = {
        let cv = CaseView(category: .confirmed)
        
        return cv
    }()
    
    let recoveredView: CaseView = {
        let cv = CaseView(category: .recovered)
        
        return cv
    }()
    
    let deathView: CaseView = {
        let cv = CaseView(category: .death)
        
        return cv
    }()
    
    lazy var caseStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.addArrangedSubview(confirmedView)
        sv.addArrangedSubview(recoveredView)
        sv.addArrangedSubview(deathView)
        
        return sv
    }()
    
    let upperContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        return view
    }()
    
    let quoteLabel: UILabel = {
        let label = UILabel()
        label.text = "We will survive.\nStay at home."
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "girl")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    lazy var taglineContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(quoteLabel)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            quoteLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            quoteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            quoteLabel.widthAnchor.constraint(equalToConstant: 200),
            quoteLabel.heightAnchor.constraint(equalToConstant: 100),
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
        ])
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        AF.request("https://covid19.mathdro.id/api").responseDecodable(of: MathdroidAPIResponse.self) { (response) in
////            print(response)
//            switch response.result {
//            case .success(let mathResponse):
//                print(mathResponse)
//            case .failure(let error):
//                print(error)
//            }
//        }
        configureUI()
    }
    
    func configureUI() {
        
        view.addSubview(upperContainerView)
        upperContainerView.addSubview(taglineContainerView)
        upperContainerView.addSubview(segmentedController)
        upperContainerView.addSubview(caseStackView)
        
        NSLayoutConstraint.activate([
            
            upperContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            upperContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            upperContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            upperContainerView.heightAnchor.constraint(equalToConstant: 300),
            
            taglineContainerView.topAnchor.constraint(equalTo: upperContainerView.topAnchor, constant: 40),
            taglineContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            taglineContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            taglineContainerView.heightAnchor.constraint(equalToConstant: 120),
            
            
            segmentedController.topAnchor.constraint(equalTo: taglineContainerView.bottomAnchor, constant: 10),
            segmentedController.leadingAnchor.constraint(equalTo: upperContainerView.leadingAnchor, constant: 20),
            segmentedController.trailingAnchor.constraint(equalTo: upperContainerView.trailingAnchor, constant: -20),
            
            caseStackView.topAnchor.constraint(equalTo: segmentedController.bottomAnchor, constant: 20),
            caseStackView.leadingAnchor.constraint(equalTo: upperContainerView.leadingAnchor, constant: 20),
            caseStackView.trailingAnchor.constraint(equalTo: upperContainerView.trailingAnchor, constant: -20),
//            caseStackView.bottomAnchor.constraint(equalTo: upperContainerView.bottomAnchor, constant: 50),
            caseStackView.heightAnchor.constraint(equalToConstant: 0.3 * view.frame.size.width)
        ])
    }
    


}

