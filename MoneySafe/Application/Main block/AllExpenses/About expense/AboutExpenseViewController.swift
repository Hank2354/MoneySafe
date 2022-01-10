//
//  AboutExpenseViewController.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation
import UIKit

class AboutExpenseViewController: UIViewController, AboutExpenseViewControllerType {
    
    var presenter: AboutExpensePresenterType?
    
    var categoryViews = [CategoryView]()
    
    var walletViews = [WalletView]()
    
    // MARK: - UI Elements
    var howMuchLabel:                    UILabel           =  {
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
    
    var desctiptionTextFieldView:        UIView            =  {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.grayForBorder.cgColor
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    lazy var desctiptionTextField:       UITextField       =  {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "Описание (Не обязательно)"
        
        textField.keyboardType = .default
        
        textField.delegate = self
        
        textField.addDoneToolBar()
        
        textField.tag = 2
        
        return textField
    }()
    
    lazy var datePickerView:             UIDatePicker      =  {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        picker.datePickerMode = .dateAndTime
        picker.locale = Locale(identifier: "en_GB")
        picker.addTarget(self, action: #selector(datePickerAction), for: .valueChanged)
        
        return picker
    }()
    
    lazy var amountTextField:            UITextField       =  {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.font = UIFont.boldSystemFont(ofSize: 32)
        textField.textColor = .white
        
        textField.placeholder = "₽"
        
        textField.keyboardType = .decimalPad
        
        textField.delegate = self
        
        textField.addDoneToolBar(onDone: nil)
        
        textField.tag = 1
        
        return textField
    }()
    
    lazy var walletsCollectionView:      UICollectionView  =  {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.bounces = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.tag = 1
        
        
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "walletCell")
        
        return collectionView
    }()
    
    lazy var categoriesCollectionView:   UICollectionView  =  {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.bounces = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.tag = 2
        
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "categoryCell")
        
        return collectionView
    }()
    
    lazy var backNavBarButton:           UIBarButtonItem   =  {
        let buttonItem = UIBarButtonItem()
        buttonItem.image = .backButtonImage
        buttonItem.tintColor = .white
        
        buttonItem.addTarget(sender: self, action: #selector(backButtonAction))
        
        return buttonItem
    }()
    
    lazy var saveButton:                 UIButton          =  {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .mainGreen
        button.layer.cornerRadius = 16
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.titleLabel?.textColor = .white
        button.isEnabled = false
        button.alpha = 0.5
        button.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    lazy var deleteButton:               UIButton          =  {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .mainRed
        button.layer.cornerRadius = 16
        button.setTitle("Удалить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.titleLabel?.textColor = .white
        button.isEnabled = true
        button.alpha = 1
        button.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Configure
    func configure()                                                             {
        
        // Setup navBar and title
        navigationItem.leftBarButtonItem = backNavBarButton
        self.title = "Детали транзакции"
        
        let bottomView = UIView()
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.layer.cornerRadius = 32
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottomView.backgroundColor = .white
        
        view.addSubview(bottomView)
        view.addSubview(amountTextField)
        view.addSubview(howMuchLabel)
        
        desctiptionTextFieldView.addSubview(desctiptionTextField)
        
        bottomView.addSubview(desctiptionTextFieldView)
        bottomView.addSubview(datePickerView)
        bottomView.addSubview(walletsCollectionView)
        bottomView.addSubview(categoriesCollectionView)
        bottomView.addSubview(saveButton)
        bottomView.addSubview(deleteButton)
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(bottomView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 1/4))
        
        constraints.append(howMuchLabel.bottomAnchor.constraint(equalTo: amountTextField.topAnchor, constant: -8))
        constraints.append(howMuchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25))
        constraints.append(howMuchLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        
        constraints.append(amountTextField.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -10))
        constraints.append(amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25))
        constraints.append(amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25))
        
        constraints.append(desctiptionTextField.centerYAnchor.constraint(equalTo: desctiptionTextFieldView.centerYAnchor))
        constraints.append(desctiptionTextField.leadingAnchor.constraint(equalTo: desctiptionTextFieldView.leadingAnchor, constant: 15))
        constraints.append(desctiptionTextField.trailingAnchor.constraint(equalTo: desctiptionTextFieldView.trailingAnchor, constant: -15))
        
        constraints.append(desctiptionTextFieldView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20))
        constraints.append(desctiptionTextFieldView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 25))
        constraints.append(desctiptionTextFieldView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -25))
        constraints.append(desctiptionTextFieldView.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(datePickerView.topAnchor.constraint(equalTo: desctiptionTextFieldView.bottomAnchor, constant: 10))
        constraints.append(datePickerView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 25))
        constraints.append(datePickerView.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(walletsCollectionView.topAnchor.constraint(equalTo: datePickerView.bottomAnchor, constant: 10))
        constraints.append(walletsCollectionView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor))
        constraints.append(walletsCollectionView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor))
        constraints.append(walletsCollectionView.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(categoriesCollectionView.topAnchor.constraint(equalTo: walletsCollectionView.bottomAnchor, constant: 10))
        constraints.append(categoriesCollectionView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor))
        constraints.append(categoriesCollectionView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor))
        constraints.append(categoriesCollectionView.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(desctiptionTextFieldView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20))
        constraints.append(desctiptionTextFieldView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 25))
        constraints.append(desctiptionTextFieldView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -25))
        constraints.append(desctiptionTextFieldView.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(deleteButton.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -10))
        constraints.append(deleteButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 25))
        constraints.append(deleteButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -25))
        constraints.append(deleteButton.heightAnchor.constraint(equalToConstant: 55))
        
        constraints.append(saveButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -10))
        constraints.append(saveButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 25))
        constraints.append(saveButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -25))
        constraints.append(saveButton.heightAnchor.constraint(equalToConstant: 55))
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func buttonTest()                                                            {
        
        var isWalletSelected: Bool = false
        var isCategorySelected: Bool = false
        var isCurrentDateSelected: Bool = false
        
        for walletView in walletViews {
            if walletView.isActive {
                isWalletSelected = true
            }
        }
        
        for categoryView in categoryViews {
            if categoryView.isActive {
                isCategorySelected = true
            }
        }
        
        if datePickerView.date <= Date() {
            isCurrentDateSelected = true
        } else {
            isCurrentDateSelected = false
        }
        
        if isWalletSelected,
           isCategorySelected,
           isCurrentDateSelected {
            saveButton.isEnabled = true
            saveButton.alpha = 1
        } else {
            saveButton.isEnabled = false
            saveButton.alpha = 0.5
        }
    }
    
    // MARK: - Public methods
    func update(with wallets: [GeneralWalletModel])                              {
        
        for wallet in wallets {
            
            let walletView = WalletView(walletModel: wallet)
            walletView.translatesAutoresizingMaskIntoConstraints = false
            walletView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                   action: #selector(walletViewTapped(tapGestureRecognizer:))))
            
            walletViews.append(walletView)
        }
        
        walletsCollectionView.reloadData()
    }
    
    func update(with categories: [GeneralCategoryModel])                         {
        
        for category in categories {
            
            let categoryView = CategoryView(categoryModel: category)
            categoryView.translatesAutoresizingMaskIntoConstraints = false
            categoryView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                   action: #selector(categoryViewTapped(tapGestureRecognizer:))))
            
            if category.categoryID.isExpenseCategoryID() {
                categoryView.categoryViewType = .expense
            } else {
                categoryView.categoryViewType = .income
            }
            
            categoryViews.append(categoryView)
        }
        
        categoriesCollectionView.reloadData()
        
    }
    
    func update(with transactionAmount: Decimal,
                descriptionText: String,
                date: Date)                                                      {
        
        
        amountTextField.text = "\(transactionAmount)".replacingOccurrences(of: ".", with: ",").applyMoneyStylePattern()
        desctiptionTextField.text = descriptionText
        datePickerView.date = date
        
    }
    
    func presentWarnMessage(alertController: UIAlertController)                  {
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - User actions
    @objc func categoryViewTapped(tapGestureRecognizer: UITapGestureRecognizer)  {
        
        guard let tappedView = tapGestureRecognizer.view as? CategoryView else { return }
        
        presenter?.changeCategoryViewStatus(tappedView: tappedView)
        
        buttonTest()
    }
    
    @objc func walletViewTapped(tapGestureRecognizer: UITapGestureRecognizer)    {
        
        guard let tappedView = tapGestureRecognizer.view as? WalletView else { return }
        
        presenter?.changeWalletViewStatus(tappedView: tappedView)
        
        buttonTest()
    }
    
    @objc func saveButtonAction()                                                {
        presenter?.saveButtonPressed()
    }
    
    @objc func backButtonAction()                                                {
        presenter?.backButtonPressed()
    }
    
    @objc func deleteButtonAction()                                              {
        presenter?.deleteButtonPressed()
    }
    
    @objc func datePickerAction()                                                {
        
        buttonTest()
        
    }
    
    // MARK: - ViewController life cycle
    override func viewDidLoad()                                                  {
        super.viewDidLoad()

        enableEndEditingModeWithTapGesture()
        self.view.backgroundColor = .mainPurple
        
        configure()
        
    }
    
    
}
