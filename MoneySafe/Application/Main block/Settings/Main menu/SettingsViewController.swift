//
//  SettingsViewController.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController, SettingsViewControllerType {
    
    var presenter: SettingsPresenterType?
    
    // MARK: - UI Elements
    lazy var backNavBarButton:  UIBarButtonItem  =   {
        let buttonItem = UIBarButtonItem()
        buttonItem.image = .backButtonImage
        buttonItem.tintColor = .white
        
        buttonItem.addTarget(sender: self, action: #selector(backAction))
        
        return buttonItem
    }()
    
    lazy var walletsButton:     SettingsButton   =   {
        let button = SettingsButton(titleText: "Мои кошельки",
                                    subTitleText: nil,
                                    logo: .logoWallet,
                                    style: .large)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(myWalletsButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    lazy var incomeCategoriesButton:  SettingsButton   =   {
        let button = SettingsButton(titleText: "Мои категории доходов",
                                    subTitleText: nil,
                                    logo: .logoCategory,
                                    style: .large)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(myIncomeCategoriesButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    lazy var expenseCategoriesButton:  SettingsButton   =   {
        let button = SettingsButton(titleText: "Мои категории расходов",
                                    subTitleText: nil,
                                    logo: .logoCategory,
                                    style: .large)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(myExpenseCategoriesButtonAction), for: .touchUpInside)
        
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
    
    func configure()                      {
        
        navigationItem.leftBarButtonItem = backNavBarButton
        self.title = "Настройки"
        
        navigationController?.setNavBarStyle(color: .mainBlue)
        
        let generalStackView = UIStackView(arrangedSubviews: [walletsButton,
                                                              incomeCategoriesButton,
                                                              expenseCategoriesButton])
        
        generalStackView.translatesAutoresizingMaskIntoConstraints = false
        generalStackView.axis = .vertical
        generalStackView.spacing = 20
        generalStackView.distribution = .fillEqually
        
        view.addSubview(generalStackView)
        
        NSLayoutConstraint.activate([
            generalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            generalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            generalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            generalStackView.heightAnchor.constraint(equalToConstant: CGFloat(generalStackView.arrangedSubviews.count * 60))
        ])
    }
    
    // MARK: - User actions
    @objc func backAction()                 {
        presenter?.backButtonPressed()
    }
    
    @objc func myWalletsButtonAction()      {
        presenter?.myWalletsButtonPressed()
    }
    
    @objc func myExpenseCategoriesButtonAction()   {
        presenter?.myExpenseCaregoriesButtonPressed()
    }
    
    @objc func myIncomeCategoriesButtonAction() {
        presenter?.myIncomeCaregoriesButtonPressed()
    }
    
    // MARK: - ViewController life cycle
    override func viewDidLoad()             {
        super.viewDidLoad()
 
        view.layer.addSublayer(getGradient())
        
        navigationController?.navigationBar.isHidden = false
        
        configure()
    }
}
