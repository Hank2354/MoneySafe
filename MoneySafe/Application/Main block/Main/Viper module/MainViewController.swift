//
//  MainViewController.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 27.12.2021.
//

import Foundation
import UIKit

class MainViewController: UIViewController, MainViewControllerType {
    
    var presenter: MainPresenterType?
    
    var currentBudgetViews = [BudgetView]()
    
    // MARK: - UI Elements
    var balanceHeaderLabel:          UILabel               =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        
        label.text = "Текущий баланс"
        
        label.textColor = .mainGray
        
        label.textAlignment = .center
        
        label.sizeToFit()
        
        return label
    }()
    
    var totalBalanceLabel:           UILabel               =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.numberOfLines = 1
        
        label.text = "99999999 ₽"
        
        label.textColor = .black
        
        label.textAlignment = .center
        
        label.sizeToFit()
        
        return label
    }()
    
    var currentMouthLabel:           UILabel               =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        
        label.text = "Текущий месяц: Unknow"
        
        label.textColor = .black
        
        label.textAlignment = .center
        
        label.sizeToFit()
        
        return label
    }()
    
    var budgetsLabel:                UILabel               =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        
        label.text = "Остаток по категориям"
        
        label.textColor = .black
        
        label.textAlignment = .center
        
        label.sizeToFit()
        
        return label
    }()
    
    lazy var newIncomeButton:        AddTransactionButton  =  {
        let button = AddTransactionButton(type: .income)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(functionButtonAction(_:)), for: .touchUpInside)
        
        button.tag = 1
        
        return button
    }()
    
    lazy var newExpenseButton:       AddTransactionButton  =  {
        let button = AddTransactionButton(type: .expense)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(functionButtonAction(_:)), for: .touchUpInside)
        
        button.tag = 2
        
        return button
    }()
    
    lazy var analyticsButton:        FunctionButton        =  {
        let button = FunctionButton(titleText: "Аналитика", logo: .logoAnalytics)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.backgroundColor = .mainCyan
        
        button.addTarget(self, action: #selector(functionButtonAction(_:)), for: .touchUpInside)
        
        button.tag = 3
        
        return button
    }()
    
    lazy var expensesButton:         FunctionButton        =  {
        let button = FunctionButton(titleText: "Расходы", logo: .logoRollOfMoney)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.backgroundColor = .mainPurple
        
        button.addTarget(self, action: #selector(functionButtonAction(_:)), for: .touchUpInside)
        
        button.tag = 4
        
        return button
    }()
    
    lazy var settingsButton:         FunctionButton        =  {
        let button = FunctionButton(titleText: "Настройки", logo: .logoSettings)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.backgroundColor = .mainDarkBlue
        
        button.addTarget(self, action: #selector(functionButtonAction(_:)), for: .touchUpInside)
        
        button.tag = 5
        
        return button
    }()
    
    var functionalButtonsStackView:  UIStackView!
    
    // MARK: - Configuration methods
    func setupLayout()                                                {
        
        // MARK: - Create header view
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: view.frame.size.width,
                                              height: 260))
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        gradientLayer.colors = [
            UIColor.yellowForGradient.cgColor,
            UIColor.white.cgColor
        ]
        gradientLayer.frame = CGRect(x: 0,
                                     y: -50,
                                     width: headerView.bounds.size.width,
                                     height: headerView.bounds.size.height + 100)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [newIncomeButton, newExpenseButton])
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 20
        buttonsStackView.distribution = .fillEqually
        
        let _functionalButtonsStackView = UIStackView(arrangedSubviews: [analyticsButton, expensesButton, settingsButton])
        _functionalButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        _functionalButtonsStackView.axis = .horizontal
        _functionalButtonsStackView.spacing = 20
        _functionalButtonsStackView.distribution = .fillEqually
        
        functionalButtonsStackView = _functionalButtonsStackView
        
        view.addSubview(headerView)
        headerView.layer.addSublayer(gradientLayer)
        headerView.addSubview(balanceHeaderLabel)
        headerView.addSubview(totalBalanceLabel)
        headerView.addSubview(buttonsStackView)
        headerView.addSubview(currentMouthLabel)
        
        view.addSubview(functionalButtonsStackView)
        view.addSubview(budgetsLabel)
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(headerView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(headerView.heightAnchor.constraint(equalToConstant: 260))
        constraints.append(headerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width))
        
        constraints.append(balanceHeaderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(balanceHeaderLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20))
        
        constraints.append(totalBalanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(totalBalanceLabel.topAnchor.constraint(equalTo: balanceHeaderLabel.bottomAnchor, constant: 10))

        constraints.append(buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        constraints.append(buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        constraints.append(buttonsStackView.bottomAnchor.constraint(equalTo: currentMouthLabel.bottomAnchor, constant: -30))
        
        constraints.append(currentMouthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(currentMouthLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10))
        
        constraints.append(functionalButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        constraints.append(functionalButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        constraints.append(functionalButtonsStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30))
        
        constraints.append(budgetsLabel.topAnchor.constraint(equalTo: functionalButtonsStackView.bottomAnchor, constant: 20))
        constraints.append(budgetsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func removeBudgetsPanel()                                         {
        var allStackViews = [UIStackView]()
        let allSubviews = view.subviews
        
        for subview in allSubviews {
            if let stackView = subview as? UIStackView {
                allStackViews.append(stackView)
            }
        }
        
        if allStackViews.count == 2 {
            for budgetsViews in allStackViews[1].arrangedSubviews {
                allStackViews[1].removeArrangedSubview(budgetsViews)
            }
            allStackViews[1].removeFromSuperview()
        }
    }
    
    func activateAnimation()                                          {
        
        UIView.animate(withDuration: 2,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0,
                       options: .curveLinear,
                       animations: {

            for budgetView in self.currentBudgetViews {
                budgetView.progressBar.setProgress(section: 0, to: budgetView.getCurrentProgressBarPosition())
            }

        })
        
    }
    
    // MARK: - Open Methods
    func update(with totalBalance: Decimal)                           {
        totalBalanceLabel.text = "\(totalBalance) ₽"
    }
    
    func update(with actualBudgetModels: [GeneralActualBudgetModel])  {
        
        var budgetViews = [BudgetView]()
        
        for budgetModel in actualBudgetModels {
            
            let budgetView = BudgetView(budgetModel: budgetModel)
            
            budgetView.translatesAutoresizingMaskIntoConstraints = false
            budgetView.progressBar.dataSource = self
            
            budgetViews.append(budgetView)
        }
        
        removeBudgetsPanel()
        
        currentBudgetViews = budgetViews
        
        let budgetsStackView = UIStackView(arrangedSubviews: currentBudgetViews)
        
        budgetsStackView.translatesAutoresizingMaskIntoConstraints = false
        budgetsStackView.axis = .vertical
        budgetsStackView.spacing = 10
        budgetsStackView.distribution = .fillEqually
        
        view.addSubview(budgetsStackView)
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(budgetsStackView.topAnchor.constraint(equalTo: budgetsLabel.bottomAnchor, constant: 10))
        constraints.append(budgetsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        constraints.append(budgetsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        constraints.append(budgetsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(budgetsStackView.heightAnchor.constraint(equalToConstant: CGFloat(currentBudgetViews.count * 55)))
        
        NSLayoutConstraint.activate(constraints)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.activateAnimation()
        }
        
        
    }
    
    func update(with mouth: String)                                   {
        currentMouthLabel.text = "Текущий месяц: \(mouth)"
    }
    
    func presentWarnMessage(title: String?, descriptionText: String?) {
        
        let alertController = UIAlertController(title: title,
                                                message: descriptionText,
                                                preferredStyle: .alert)
        
        let okBtn = UIAlertAction(title: "OK",
                                  style: .default,
                                  handler: nil)
        
        alertController.addAction(okBtn)
        
        present(alertController,
                animated: true,
                completion: nil)
    }
    
    // MARK: - User actions
    @objc func functionButtonAction(_ sender: UIButton)               {
        presenter?.functionButtonPressed(sender)
    }
    
    // MARK: - ViewController life cycle
    override func loadView()                                          {
        self.view = UIScrollView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: UIScreen.main.bounds.width,
                                               height: UIScreen.main.bounds.height))
        
        (view as! UIScrollView).delegate = self
    }
    
    override func viewDidLoad()                                       {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool)                    {
        super.viewWillAppear(animated)
        
        presenter?.updateData()
        self.navigationController?.navigationBar.isHidden = true
        
        
    }
    
}
