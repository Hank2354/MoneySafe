//
//  BudgetsSettingsViewController.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation
import UIKit

class BudgetsSettingsViewController: UIViewController, BudgetsSettingsViewControllerType {
    
    var presenter: BudgetsSettingsPresenterType?
    
    var toButtonConstraint: NSLayoutConstraint?
    
    var categoryViews = [CategoryView]()
    
    var budgetTextFields = [BudgetTextField]()
    
    // MARK: - Create UI Elements
    var headerLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
    
        label.text = "Изменение бюджетов"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
    
        label.sizeToFit()
    
        return label
    }()
    
    var descriptionLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        label.text = "Укажите бюджеты для категорий, или можете оставить поле пустым"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .white
        
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        
        return label
    }()
    
    var categoriesScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.bounces = true
        
        return scrollView
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.isEnabled = true
        
        button.alpha = 1
        
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        
        button.backgroundColor = .white
        
        button.layer.cornerRadius = 16
        
        button.addTarget(self, action: #selector(saveSettings), for: .touchUpInside)
        
        return button
    }()
    
    lazy var backNavBarButton: UIBarButtonItem = {
        let buttonItem = UIBarButtonItem()
        buttonItem.title = "<"
        buttonItem.tintColor = .black
        
        buttonItem.addTarget(sender: self, action: #selector(backAction))
        
        return buttonItem
    }()
    
    // MARK: - Configuration methods
    private func setupLayout() {
        
        // MARK: - General setup
        view.addSubview(headerLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(categoriesScrollView)
        view.addSubview(continueButton)
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1))
        constraints.append(headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20))
        constraints.append(headerLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 90))
        
        constraints.append(descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15))
        constraints.append(descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20))
        
        constraints.append(categoriesScrollView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15))
        constraints.append(categoriesScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15))
        constraints.append(categoriesScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15))
        constraints.append(categoriesScrollView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -20))
        
        constraints.append(continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10))
        constraints.append(continueButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(continueButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10))
        constraints.append(continueButton.heightAnchor.constraint(equalToConstant: 50))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - User actions
    @objc func saveSettings() {
        presenter?.isContinueButtonPressed()
    }
    
    @objc func backAction() {
        presenter?.isBackButtonPressed()
    }
    
    @objc func doneButtonAction() {
        presenter?.isDoneButtonPressed()
    }
    
    @objc func kbDidShow(notification: Notification) {
        
        guard let userInfo = notification.userInfo else { return }
        
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        if toButtonConstraint == nil {
            toButtonConstraint = categoriesScrollView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -(kbFrameSize.height - 60))
        }
        
        toButtonConstraint?.isActive = true
    }
    
    @objc func kbDidHide(notification: Notification) {
        toButtonConstraint?.isActive = false
    }
                                                    
    // MARK: - Open methods
    func update(with categories: [GeneralCategoryModel]) {
        
        var itag: Int = 1
        for category in categories {
            
            let myView = CategoryView(categoryModel: category)
            
            myView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            myView.categoryViewType = category.categoryType
            
            
            let budgetTextField = BudgetTextField(categoryID: category.categoryID)
            
            budgetTextField.placeholder = "15000 ₽"
            budgetTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
            budgetTextField.delegate = self
            budgetTextField.keyboardType = .decimalPad
            budgetTextField.tag = itag
            budgetTextField.addDoneCancelToolBar(onDone: (target: self, action: #selector(doneButtonAction)))
            
            itag += 1
            
            categoryViews.append(myView)
            budgetTextFields.append(budgetTextField)
        }
        
        let leftColumnStackView = UIStackView(arrangedSubviews: categoryViews)
        leftColumnStackView.translatesAutoresizingMaskIntoConstraints = false
        leftColumnStackView.axis = .vertical
        leftColumnStackView.spacing = 20
        
        let rightColumnStackView = UIStackView(arrangedSubviews: budgetTextFields)
        rightColumnStackView.translatesAutoresizingMaskIntoConstraints = false
        rightColumnStackView.axis = .vertical
        rightColumnStackView.spacing = 20
        
        let generalStackView = UIStackView(arrangedSubviews: [leftColumnStackView, rightColumnStackView])
        generalStackView.translatesAutoresizingMaskIntoConstraints = false
        generalStackView.axis = .horizontal
        generalStackView.spacing = 20
        generalStackView.distribution = .fillEqually
        
        categoriesScrollView.addSubview(generalStackView)
        
        NSLayoutConstraint.activate([
            generalStackView.widthAnchor.constraint(equalToConstant: view.frame.width - 30),
            generalStackView.leadingAnchor.constraint(equalTo: categoriesScrollView.leadingAnchor),
            generalStackView.trailingAnchor.constraint(equalTo: categoriesScrollView.trailingAnchor),
            generalStackView.topAnchor.constraint(equalTo: categoriesScrollView.topAnchor),
            generalStackView.bottomAnchor.constraint(equalTo: categoriesScrollView.bottomAnchor)
        ])
        
        presenter?.updateTextFieldValues()
        
    }
    
    // MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBlue
        
        navigationItem.leftBarButtonItem = backNavBarButton
        
        setupLayout()
        enableEndEditingModeWithTapGesture()
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        budgetTextFields.first?.becomeFirstResponder()
        
    }
}
