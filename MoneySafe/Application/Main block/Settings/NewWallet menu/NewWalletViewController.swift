//
//  NewWalletViewController.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 02.01.2022.
//

import Foundation
import UIKit

class NewWalletViewController: UIViewController, NewWalletViewControllerType {
    
    var presenter: NewWalletPresenterType?
    
    // MARK: - UI Elements
    var desctiptionTextFieldView:   UIView            =   {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.grayForBorder.cgColor
        view.layer.cornerRadius = 16
        
        return view
        
    }()
    
    var howMuchLabel:               UILabel           =   {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 1
        
        label.text = "Сколько?"
        
        label.textColor = .lightGrayForHowMuchLabel
        
        label.textAlignment = .left
        
        label.sizeToFit()
        
        return label
        
    }()
    
    lazy var amountTextField:       UITextField       =   {
        
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.font = UIFont.boldSystemFont(ofSize: 32)
        textField.textColor = .white
        
        textField.placeholder = "₽"
        
        textField.keyboardType = .decimalPad
        
        textField.delegate = self
        
        textField.tag = 1
        
        textField.addDoneToolBar(onDone: nil)
        
        return textField
        
    }()
    
    lazy var desctiptionTextField:  UITextField       =   {
        
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "Название (обязательно)"
        
        textField.keyboardType = .default
        
        textField.delegate = self
        
        textField.tag = 2
        
        textField.addDoneToolBar(onDone: nil)
        
        return textField
        
    }()
    
    lazy var saveButton:            UIButton          =   {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .mainBlue
        button.layer.cornerRadius = 16
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.titleLabel?.textColor = .white
        button.isEnabled = true
        button.alpha = 1
        button.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    lazy var backNavBarButton:      UIBarButtonItem   =   {
        
        let buttonItem = UIBarButtonItem()
        buttonItem.image = .backButtonImage
        buttonItem.tintColor = .white
        
        buttonItem.addTarget(sender: self, action: #selector(backButtonAction))
        
        return buttonItem
    }()
    
    // MARK: - Configuration methods
    func configure()                                    {
        
        navigationItem.leftBarButtonItem = backNavBarButton
        self.title = "Добавить кошелек"
        
        let bottomView = UIView()
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.layer.cornerRadius = 32
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottomView.backgroundColor = .white
        
        view.addSubview(bottomView)
        view.addSubview(amountTextField)
        view.addSubview(howMuchLabel)
        
        bottomView.addSubview(desctiptionTextFieldView)
        
        desctiptionTextFieldView.addSubview(desctiptionTextField)
        
        bottomView.addSubview(saveButton)
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(saveButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -10))
        constraints.append(saveButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 25))
        constraints.append(saveButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -25))
        constraints.append(saveButton.heightAnchor.constraint(equalToConstant: 55))
        
        constraints.append(desctiptionTextField.centerYAnchor.constraint(equalTo: desctiptionTextFieldView.centerYAnchor))
        constraints.append(desctiptionTextField.leadingAnchor.constraint(equalTo: desctiptionTextFieldView.leadingAnchor, constant: 15))
        constraints.append(desctiptionTextField.trailingAnchor.constraint(equalTo: desctiptionTextFieldView.trailingAnchor, constant: -15))
        
        constraints.append(desctiptionTextFieldView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20))
        constraints.append(desctiptionTextFieldView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 25))
        constraints.append(desctiptionTextFieldView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -25))
        constraints.append(desctiptionTextFieldView.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(howMuchLabel.bottomAnchor.constraint(equalTo: amountTextField.topAnchor, constant: -10))
        constraints.append(howMuchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25))
        constraints.append(howMuchLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        
        constraints.append(amountTextField.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -10))
        constraints.append(amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25))
        constraints.append(amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25))
        
        constraints.append(bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(bottomView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 1/4))
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    // MARK: - Public methods
    func presentWarnMessage(alertController: UIAlertController) {
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - User actions
    @objc func backButtonAction() {
        presenter?.backButtonPressed()
    }
    
    @objc func saveButtonAction() {
        presenter?.saveButtonPressed()
    }
    
    // MARK: - ViewController Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainBlue
        
        configure()
    }
    
}
