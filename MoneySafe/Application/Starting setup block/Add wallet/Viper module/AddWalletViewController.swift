//
//  AddWalletViewController.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 19.12.2021.
//

import Foundation
import UIKit


class AddWalletViewController: UIViewController, AddWalletViewControllerType {

    var presenter: AddWalletPresenterType?
    
    
    // MARK: - UI Elements
    private var headerLabel:               UILabel          =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        label.text = "Хорошо, теперь добавим еще один кошелек"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        
        label.sizeToFit()
        
        return label
    }()
    
    private var descriptionLabel:          UILabel          =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        label.text = "Например карточку или счет в банке"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        
        return label
    }()
    
    private var moneyTextFieldView:        UIView           =  {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.grayForBorder.cgColor
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    private var walletNameTextFieldView:   UIView           =  {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.grayForBorder.cgColor
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    lazy var walletNameTextField:          UITextField      =  {
        let textField = WalletSetupTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "Название (например Сбербанк)"
        
        textField.keyboardType = .default
        
        textField.delegate = self
        
        textField.contentType = .objectName
        
        textField.addDoneToolBar(onDone: nil)
        
        return textField
    }()
    
    lazy var moneyCountTextField:          UITextField      =  {
        let textField = WalletSetupTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "Сумма на кошельке"
        
        textField.keyboardType = .decimalPad
        
        textField.delegate = self
        
        textField.contentType = .countMoney
        
        textField.addDoneToolBar(onDone: nil)
        
        return textField
    }()
    
    private lazy var skipButton:           UIButton         =  {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Ничего больше не добавляем", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.lazyGray, for: .normal)
        
        button.addTarget(self, action: #selector(skipAddingWallet), for: .touchUpInside)
        
        return button
    }()

    private lazy var continueButton:       UIButton         =  {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.isEnabled = false
        
        button.alpha = 0.5
        
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        
        button.backgroundColor = .mainPurple
        
        button.layer.cornerRadius = 16
        
        button.addTarget(self, action: #selector(saveWallet), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var backNavBarButton:     UIBarButtonItem  =  {
        let buttonItem = UIBarButtonItem()
        buttonItem.title = "<"
        buttonItem.tintColor = .black
        
        buttonItem.addTarget(sender: self, action: #selector(backAction))
        
        return buttonItem
    }()
    
    
    
    // MARK: - Configuration methods
    private func setupLayout()                  {
        
        // MARK: - Create TextFields StackView
        walletNameTextFieldView.addSubview(walletNameTextField)
        
        NSLayoutConstraint.activate([
            walletNameTextField.leadingAnchor.constraint(equalTo: walletNameTextFieldView.leadingAnchor, constant: 15),
            walletNameTextField.trailingAnchor.constraint(equalTo: walletNameTextFieldView.trailingAnchor, constant: -15),
            walletNameTextField.topAnchor.constraint(equalTo: walletNameTextFieldView.topAnchor),
            walletNameTextField.bottomAnchor.constraint(equalTo: walletNameTextFieldView.bottomAnchor)
        ])
        
        moneyTextFieldView.addSubview(moneyCountTextField)
        
        NSLayoutConstraint.activate([
            moneyCountTextField.leadingAnchor.constraint(equalTo: moneyTextFieldView.leadingAnchor, constant: 15),
            moneyCountTextField.trailingAnchor.constraint(equalTo: moneyTextFieldView.trailingAnchor, constant: -15),
            moneyCountTextField.topAnchor.constraint(equalTo: moneyTextFieldView.topAnchor),
            moneyCountTextField.bottomAnchor.constraint(equalTo: moneyTextFieldView.bottomAnchor)
        ])
        
        let textFieldsStackView = UIStackView(arrangedSubviews: [walletNameTextFieldView, moneyTextFieldView])
        textFieldsStackView.translatesAutoresizingMaskIntoConstraints = false
        textFieldsStackView.distribution = .fillEqually
        textFieldsStackView.axis = .vertical
        textFieldsStackView.spacing = 10
        
        // MARK: - Create StackView with buttoms
        let bottomStackView = UIStackView(arrangedSubviews: [skipButton, continueButton])
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.distribution = .fillEqually
        bottomStackView.axis = .vertical
        bottomStackView.spacing = 10
        
        // MARK: - General setup
        view.addSubview(headerLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(textFieldsStackView)
        view.addSubview(bottomStackView)
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1))
        constraints.append(headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20))
        constraints.append(headerLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 90))
        
        constraints.append(descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15))
        constraints.append(descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20))
        
        constraints.append(textFieldsStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15))
        constraints.append(textFieldsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15))
        constraints.append(textFieldsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15))
        constraints.append(textFieldsStackView.heightAnchor.constraint(equalToConstant: 110))
        
        constraints.append(bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10))
        constraints.append(bottomStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(bottomStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10))
        constraints.append(bottomStackView.heightAnchor.constraint(equalToConstant: 130))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func activateContinueButton()               {
        continueButton.isEnabled = true
        continueButton.alpha = 1
    }
    
    func deactivateContinueButton()             {
        continueButton.isEnabled = false
        continueButton.alpha = 0.5
    }
    
    // MARK: - Public methods
    
    func presentWarnMessage(with text: String)  {
        let alertController = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
        
        alertController.addAction(okButton)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func saveWallet()                     {
        presenter?.isContinueButtonPressed()
    }
    
    @objc func skipAddingWallet()               {
        presenter?.isSkipButtonPressed()
    }
    
    @objc func backAction()                     {
        presenter?.isBackButtonPressed()
    }
    
    
    // MARK: - ViewController life cycle
    override func viewDidLoad()                 {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = backNavBarButton
        
        view.backgroundColor = .white
        
        enableEndEditingModeWithTapGesture()
        setupLayout()
    }
    
}
