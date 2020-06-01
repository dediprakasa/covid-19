//
//  InfoVC.swift
//  Covid19
//
//  Created by Dedi Prakasa on 5/10/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {
    
    let scrollView = UIScrollView()
    var type: InfoType?
    var text: String!

    let label = UILabel()
    
    var descHeight: CGFloat = 1000
    
    let descContainerView = UIView()
    
    init(type: InfoType) {
        super.init(nibName: nil, bundle: nil)
        self.type = type
        switch type {
        case .overview:
            text = InfoData.overview
        case .symptoms:
            text = InfoData.symptoms
        case .prevention:
            text = InfoData.prevention
        case .qna:
            text = InfoData.qna
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureScrollView()
        configureLabel()
        configureDecContainerView()
        configureViewController()
        configureAll()
    }
    
    
    func configureLabel() {
        label.text = text
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
//        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureDecContainerView() {
        descHeight = UIHelper.getDescriptionLabelHeight(text: text, fontSize: 16, inView: self.view, padding: 20)
        descContainerView.addSubview(label)
        descContainerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: descContainerView.topAnchor),
            label.leadingAnchor.constraint(equalTo: descContainerView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: descContainerView.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: descHeight)
        ])
    }
    
    func configureScrollView() {
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: descHeight * 1.5)
        scrollView.isUserInteractionEnabled = true
        scrollView.frame = self.view.bounds
        
        scrollView.addSubview(descContainerView)
    }
    
    
    func configureAll() {
        
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
//            scrollView.heightAnchor.constraint(equalToConstant: descHeight)
            
            descContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            descContainerView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            descContainerView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            descContainerView.heightAnchor.constraint(equalToConstant: descHeight)
        ])

    }
    
    func configureViewController() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismssVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    @objc func dismssVC() {
        dismiss(animated: true)
    }

}
