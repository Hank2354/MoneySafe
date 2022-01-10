//
//  WalletsSettingsViewController.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation
import UIKit

class WalletsSettingsViewController: UIViewController, WalletsSettingsViewControllerType {
    
    var presenter: WalletsSettingsPresenterType?
    
    var wallets = [GeneralWalletModel]()
    
    // MARK: - UI Elements
    lazy var backNavBarButton:       UIBarButtonItem   =   {
        let buttonItem = UIBarButtonItem()
        buttonItem.image = .backButtonImage
        buttonItem.tintColor = .white
        
        buttonItem.addTarget(sender: self, action: #selector(backAction))
        
        return buttonItem
    }()
    
    lazy var walletsCollectionView:  UICollectionView  =   {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.bounces = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.tag = 1
        
        collectionView.backgroundColor = .clear
        
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "customCell")
        
        return collectionView
        
    }()
    
    lazy var addNewWalletButton:     UIButton          =   {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .mainBlue
        button.layer.cornerRadius = 16
        button.setTitle("Добавить кошелек", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.titleLabel?.textColor = .white
        button.isEnabled = true
        button.alpha = 1
        button.addTarget(self, action: #selector(addWalletButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Configuration methods
    func getGradient() -> CAGradientLayer   {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        gradientLayer.colors = [
            UIColor.mainBlue.cgColor,
            UIColor.white.cgColor
        ]
        gradientLayer.frame = CGRect(x: 0,
                                     y: 0,
                                     width: view.bounds.size.width,
                                     height: view.bounds.size.height + 100)
        
        return gradientLayer
    }
    
    func configure()                        {
        
        navigationItem.leftBarButtonItem = backNavBarButton
        self.title = "Настройки"
        
        view.addSubview(walletsCollectionView)
        view.addSubview(addNewWalletButton)
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(walletsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10))
        constraints.append(walletsCollectionView.bottomAnchor.constraint(equalTo: addNewWalletButton.topAnchor, constant: -10))
        constraints.append(walletsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        constraints.append(walletsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        
        constraints.append(addNewWalletButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10))
        constraints.append(addNewWalletButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25))
        constraints.append(addNewWalletButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25))
        constraints.append(addNewWalletButton.heightAnchor.constraint(equalToConstant: 55))
        
        NSLayoutConstraint.activate(constraints)
    
    }
    
    // MARK: - Public methods
    func update(with walletModels: [GeneralWalletModel]) {
        
        wallets = walletModels
        walletsCollectionView.reloadData()
        
    }
    
    func presentController(alertController: UIAlertController) {
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: - User actions
    @objc func backAction()                 {
        presenter?.isBackButtonPressed()
    }
    
    @objc func addWalletButtonAction()      {
        presenter?.isAddWalletButtonPressed()
    }
    
    // MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.addSublayer(getGradient())
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.updateData()
    }
}
