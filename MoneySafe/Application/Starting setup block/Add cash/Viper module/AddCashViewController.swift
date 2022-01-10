//
//  ViewController.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 19.12.2021.
//

import Foundation
import UIKit


class AddCashViewController: UIViewController, AddCashViewControllerType {

    var presenter: AddCashPresenterType?
    
    
    // MARK: - UI Elements
    private var headerLabel:           UILabel      = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        label.text = "Заголовок"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        
        label.sizeToFit()
        
        return label
    }()
    
    private var descriptionLabel:      UILabel      = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        label.text = "Описание"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        
        return label
    }()
    
    private var textFieldView:         UIView       = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.grayForBorder.cgColor
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    lazy var moneyTextField:           UITextField  = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "1000 ₽"
        
        textField.keyboardType = .decimalPad
        
        textField.delegate = self
        
        textField.addDoneToolBar(onDone: nil)
        
        return textField
    }()
    
    private var imageView:             UIImageView  = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var skipButton:       UIButton     = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Я не пользуюсь наличкой", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.lazyGray, for: .normal)
        
        button.addTarget(self, action: #selector(skipCash), for: .touchUpInside)
        
        return button
    }()

    private lazy var continueButton:   UIButton     = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.isEnabled = false
        
        button.alpha = 0.5
        
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        
        button.backgroundColor = .mainPurple
        
        button.layer.cornerRadius = 16
        
        button.addTarget(self, action: #selector(saveCashCount), for: .touchUpInside)
        
        return button
    }()

    
    
    // MARK: - Configurations methods
    private func setupLayout()        {
        
        textFieldView.addSubview(moneyTextField)
        
        NSLayoutConstraint.activate([
            moneyTextField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 15),
            moneyTextField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -15),
            moneyTextField.topAnchor.constraint(equalTo: textFieldView.topAnchor),
            moneyTextField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor)
        ])
        
        let bottomStackView = UIStackView(arrangedSubviews: [skipButton, continueButton])
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.distribution = .fillEqually
        bottomStackView.axis = .vertical
        bottomStackView.spacing = 10
        
        view.addSubview(headerLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(textFieldView)
        view.addSubview(imageView)
        view.addSubview(bottomStackView)
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1))
        constraints.append(headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20))
        constraints.append(headerLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 40))
        
        constraints.append(descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15))
        constraints.append(descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20))
        
        constraints.append(textFieldView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15))
        constraints.append(textFieldView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15))
        constraints.append(textFieldView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15))
        constraints.append(textFieldView.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(imageView.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 15))
        constraints.append(imageView.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40))
        constraints.append(imageView.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40))
        constraints.append(imageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomStackView.topAnchor, constant: -15))
        
        constraints.append(bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10))
        constraints.append(bottomStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(bottomStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10))
        constraints.append(bottomStackView.heightAnchor.constraint(equalToConstant: 130))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configure()          {
        headerLabel.text = "Добавим наличные!"
        descriptionLabel.text = "Укажите пожалуйста, сколько у вас сейчас наличных денег?"
        imageView.image = UIImage(named: "moneyImage")
    }
    
    
    // MARK: - Public methods
    func activateContinueButton()     {
        continueButton.isEnabled = true
        continueButton.alpha = 1
    }
    
    func deactivateContinueButton()   {
        continueButton.isEnabled = false
        continueButton.alpha = 0.5
    }
    
    @objc func saveCashCount()        {
        presenter?.isContinueButtonPressed()
    }
    
    @objc func skipCash()             {
        presenter?.isSkipButtonPressed()
    }
    
    
    // MARK: - ViewController life cycle
    override func viewDidLoad()       {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        enableEndEditingModeWithTapGesture()
        setupLayout()
        configure()
        
    }
    
}
