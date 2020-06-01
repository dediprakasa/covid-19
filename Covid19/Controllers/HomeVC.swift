//
//  HomeVC.swift
//  Covid19
//
//  Created by Dedi Prakasa on 5/7/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit
//import Alamofire

class HomeVC: UIViewController {
    
    let type: [InfoType] = [.overview, .symptoms, .prevention, .qna]
    
    lazy var infoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 20
        layout.sectionInset = UIEdgeInsets(top: padding/2, left: padding, bottom: padding/2, right: padding)
        layout.itemSize = CGSize(width: self.view.bounds.width - 2 * padding, height: 100)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
        
    }()
    
    var response: MathdroidAPIResponse?
    var pickerData = [Country]()
    
    let confirmedView = CaseView(category: .confirmed)
    let recoveredView = CaseView(category: .recovered)
    let deathView = CaseView(category: .death)
    
    lazy var textField: UITextField = {
        let tf = UITextField(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
        tf.setUnderLine()
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.textColor = .white
        tf.tintColor = .clear
        tf.textAlignment = .center
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.delegate = self
        
        
        return tf
    }()
    
    let selectCountryLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Country"
        label.textColor = .white
        return label
    }()
    
    lazy var selectCountry: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.addArrangedSubview(self.selectCountryLabel)
        sv.addArrangedSubview(self.textField)
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        
        return sv
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
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "What you need to know"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
    
    let SymptomsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        
        return cv
    }()
    
    let infoStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false

        return sv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        NetworkManager.shared.getMyCountryData(country: "Worldwide") { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.sync {
                    self.confirmedView.setData(numberOfCase: data.confirmed.value)
                    self.recoveredView.setData(numberOfCase: data.recovered.value)
                    self.deathView.setData(numberOfCase: data.deaths.value)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        NetworkManager.shared.getCountries { (result) in
            switch result {
            case .success(let arrCountries):
                let ww = Country(name: "Worldwide", iso2: nil)
                self.pickerData.append(ww)
                self.pickerData.append(contentsOf: arrCountries.countries)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        configureUI()
        configurePickerView()
        dismissPickerView()
        configureCollectionView()
    }
    
    func configurePickerView() {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .systemBlue
        pickerView.delegate = self
        pickerView.dataSource = self
        textField.inputView = pickerView
        textField.text = "Worldwide"
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        toolBar.backgroundColor = .systemBlue
        toolBar.layer.cornerRadius = 15
        toolBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        toolBar.clipsToBounds = true
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneTapped))

        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    @objc func doneTapped() {
        view.endEditing(true)
        getData(for: textField.text!)
    }
    
    func getData(for country: String) {
        NetworkManager.shared.getMyCountryData(country: country) { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.sync {
                    self.confirmedView.setData(numberOfCase: data.confirmed.value)
                    self.recoveredView.setData(numberOfCase: data.recovered.value)
                    self.deathView.setData(numberOfCase: data.deaths.value)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func configureCollectionView() {
        infoCollectionView.delegate = self
        infoCollectionView.dataSource = self
        infoCollectionView.register(InfoCell.self, forCellWithReuseIdentifier: InfoCell.reuseID)
    }
    
    func configureUI() {
        view.addSubview(upperContainerView)
        upperContainerView.addSubview(taglineContainerView)
        upperContainerView.addSubview(selectCountry)
        upperContainerView.addSubview(caseStackView)
        
        view.addSubview(infoLabel)
        view.addSubview(infoCollectionView)
        
        NSLayoutConstraint.activate([
            
            upperContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            upperContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            upperContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            upperContainerView.heightAnchor.constraint(equalToConstant: 300),
            
            taglineContainerView.topAnchor.constraint(equalTo: upperContainerView.topAnchor, constant: 40),
            taglineContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            taglineContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            taglineContainerView.heightAnchor.constraint(equalToConstant: 120),
            
            selectCountry.topAnchor.constraint(equalTo: taglineContainerView.bottomAnchor, constant: 10),
            selectCountry.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectCountry.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            selectCountry.heightAnchor.constraint(equalToConstant: 25),
            
            caseStackView.topAnchor.constraint(equalTo: selectCountry.bottomAnchor, constant: 20),
            caseStackView.leadingAnchor.constraint(equalTo: upperContainerView.leadingAnchor, constant: 20),
            caseStackView.trailingAnchor.constraint(equalTo: upperContainerView.trailingAnchor, constant: -20),
            caseStackView.heightAnchor.constraint(equalToConstant: 0.3 * view.frame.size.width),
            
            infoLabel.topAnchor.constraint(equalTo: caseStackView.bottomAnchor, constant: 30),
            infoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            infoCollectionView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
            infoCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            infoCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            infoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
}

extension HomeVC: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = pickerData[row].name
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: pickerData[row].name, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCell.reuseID, for: indexPath) as! InfoCell
        cell.set(type: type[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let targetVC = InfoVC(type: type[indexPath.row])
        let navController   = UINavigationController(rootViewController: targetVC)
        self.present(navController, animated: true)
        print(indexPath.row)
    }
    
}

