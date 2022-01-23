//
//  NewIncomeController.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 27.12.2021.
//

import Foundation
import UIKit

class NewIncomeViewController: UIViewController, NewIncomeViewControllerType {
    
    var presenter: NewIncomePresenterType?
    
    var walletViews = [WalletView]()
    
    var categoryViews = [CategoryView]()
    
    // MARK: - UI Elements
    var titleLabel:                     UILabel           =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 1
        
        label.text = "Новый доход"
        
        label.textColor = .white
        
        label.textAlignment = .center
        
        label.sizeToFit()
        
        return label
    }()
    
    var howMuchLabel:                   UILabel           =  {
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
    
    var chooseCategoryLabel:            UILabel           =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        
        label.text = "Выберите категорию"
        
        label.textColor = .black
        
        label.textAlignment = .left
        
        label.sizeToFit()
        
        return label
    }()
    
    var desctiptionTextFieldView:       UIView            =  {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.grayForBorder.cgColor
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    lazy var desctiptionTextField:      UITextField       =  {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "Описание (Не обязательно)"
        
        textField.keyboardType = .default
        
        textField.delegate = self
        
        textField.tag = 2
        
        textField.addDoneToolBar(onDone: nil)
        
        return textField
    }()
    
    lazy var amountTextField:           UITextField       =  {
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
    
    lazy var walletsCollectionView:     UICollectionView  =  {
        
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
    
    lazy var categoriesCollectionView:  UICollectionView  =  {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.layer.borderWidth = 0.5
        collectionView.layer.cornerRadius = 10
        collectionView.layer.borderColor = UIColor.black.cgColor
        
        collectionView.bounces = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.tag = 2
        
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "categoryCell")
        
        return collectionView
    }()
    
    lazy var backButton:                UIButton          =  {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        
        button.setImage(.backButtonImage, for: .normal)
        
        return button
    }()
    
    lazy var saveButton:                UIButton          =  {
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
    
    // MARK: - Configure
    func setupLayout()                                                           {
        
        let bottomView = UIView()
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.layer.cornerRadius = 32
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottomView.backgroundColor = .white
        
        view.addSubview(bottomView)
        view.addSubview(titleLabel)
        view.addSubview(amountTextField)
        view.addSubview(howMuchLabel)
        view.addSubview(backButton)
        
        bottomView.addSubview(desctiptionTextFieldView)
        
        desctiptionTextFieldView.addSubview(desctiptionTextField)
        
        bottomView.addSubview(walletsCollectionView)
        bottomView.addSubview(chooseCategoryLabel)
        bottomView.addSubview(saveButton)
        bottomView.addSubview(categoriesCollectionView)
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25))
        constraints.append(backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor))
        constraints.append(backButton.heightAnchor.constraint(equalToConstant: 32))
        constraints.append(backButton.widthAnchor.constraint(equalToConstant: 32))
        
        constraints.append(categoriesCollectionView.topAnchor.constraint(equalTo: chooseCategoryLabel.bottomAnchor, constant: 5))
        constraints.append(categoriesCollectionView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -10))
        constraints.append(categoriesCollectionView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 5))
        constraints.append(categoriesCollectionView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -5))
        
        constraints.append(saveButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -10))
        constraints.append(saveButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 25))
        constraints.append(saveButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -25))
        constraints.append(saveButton.heightAnchor.constraint(equalToConstant: 55))
        
        constraints.append(chooseCategoryLabel.topAnchor.constraint(equalTo: walletsCollectionView.bottomAnchor, constant: 10))
        constraints.append(chooseCategoryLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20))
        constraints.append(chooseCategoryLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20))
        
        constraints.append(walletsCollectionView.topAnchor.constraint(equalTo: desctiptionTextFieldView.bottomAnchor, constant: 10))
        constraints.append(walletsCollectionView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor))
        constraints.append(walletsCollectionView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor))
        constraints.append(walletsCollectionView.heightAnchor.constraint(equalToConstant: 50))
        
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
        
        constraints.append(titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30))
        constraints.append(titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        
        constraints.append(bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(bottomView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 1/4))
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func buttonTest()                                                            {
        
        var isWalletSelected: Bool = false
        var isCategorySelected: Bool = false
        
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
        
        if isWalletSelected,
           isCategorySelected {
            saveButton.isEnabled = true
            saveButton.alpha = 1
        } else {
            saveButton.isEnabled = false
            saveButton.alpha = 0.5
        }
    }
    
    // MARK: - Open Methods
    func update(with wallets: [GeneralWalletModel])                              {
        
        for wallet in wallets {
            
            let walletView = WalletView(walletModel: wallet)
            walletView.translatesAutoresizingMaskIntoConstraints = false
            walletView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                   action: #selector(walletViewTapped(tapGestureRecognizer:))))
            
            walletViews.append(walletView)
        }
        
    }
    
    func update(with categories: [GeneralCategoryModel])                         {
        
        for category in categories {
            
            let categoryView = CategoryView(categoryModel: category)
            categoryView.translatesAutoresizingMaskIntoConstraints = false
            categoryView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                   action: #selector(categoryViewTapped(tapGestureRecognizer:))))
            categoryView.categoryViewType = .income
            
            categoryViews.append(categoryView)
        }
        
    }
    
    func presentWarnMessage(alertController: UIAlertController)                  {
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - User actions
    @objc func categoryViewTapped(tapGestureRecognizer: UITapGestureRecognizer)  {
        
        guard let tappedView = tapGestureRecognizer.view as? CategoryView else { return }
        
        presenter?.changeCategoryViewStatus(tappedView: tappedView)
        
        buttonTest()
        
        view.endEditing(true)
    }
    
    @objc func walletViewTapped(tapGestureRecognizer: UITapGestureRecognizer)    {
        
        guard let tappedView = tapGestureRecognizer.view as? WalletView else { return }
        
        presenter?.changeWalletViewStatus(tappedView: tappedView)
        
        buttonTest()
        
        view.endEditing(true)
    }
    
    @objc func saveButtonAction()                                                {
        presenter?.saveButtonPressed()
    }
    
    @objc func backButtonAction()                                                {
        presenter?.backButtonPressed()
    }
    
    // MARK: - ViewController life cycle
    override func viewDidLoad()                                                  {
        super.viewDidLoad()

        enableEndEditingModeWithTapGesture()
        self.view.backgroundColor = .mainGreen
        self.navigationController?.navigationBar.isHidden = true
        
        setupLayout()
        
    }
    
    override func viewWillDisappear(_ animated: Bool)                            {
        super.viewWillDisappear(animated)
        
        // For update data on main ViewController
        // (Because method ViewWillAppear is not being after dismiss this ViewController if was present modally)
        let presentingNC = presentingViewController as? UINavigationController
        presentingNC?.viewControllers.first?.viewWillAppear(true)
    }

}
