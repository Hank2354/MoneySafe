//
//  AllExpensesTableViewController.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import UIKit

class AllExpensesTableViewController: UITableViewController, AllExpensesTableViewControllerType {
    
    var presenter:       AllExpensesPresenterType?
    
    var transactions  =  [[GeneralTransactionModel]]()
    
    // MARK: - UI Elements
    lazy var backNavBarButton:  UIBarButtonItem        =      {
        let buttonItem = UIBarButtonItem()
        buttonItem.image = .backButtonImage
        buttonItem.tintColor = .white
        
        buttonItem.addTarget(sender: self, action: #selector(backAction))
        
        return buttonItem
    }()

    // MARK: - Configuration methods
    func config()                                             {
        
        // Setup tableView
        tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.separatorColor = .clear
        tableView.backgroundColor = .white
        
        tableView.register(AllExpensesCell.self, forCellReuseIdentifier: "cell")
        
        // Setup navBar and title
        navigationItem.leftBarButtonItem = backNavBarButton
        self.title = "Расходы"
        
        navigationController?.setNavBarStyle(color: .mainPurple)
        
    }
    
    // MARK: - Public methods
    func presentWarnMessage(title: String?, message: String?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okButton)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func update(with data: [[GeneralTransactionModel]])       {
        
        transactions = data
        
    }
    
    // MARK: - User actions
    @objc func backAction()                                   {
        presenter?.backButtonPressed()
    }
    
    // MARK: - ViewController life cycle
    override func viewDidLoad()                               {
        super.viewDidLoad()
        
        
        config()
        
    }
    
    override func viewWillAppear(_ animated: Bool)            {
        presenter?.updateData()
        self.navigationController?.navigationBar.isHidden = false
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
}
