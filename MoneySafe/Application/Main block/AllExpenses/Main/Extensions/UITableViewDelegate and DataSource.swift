//
//  UITableViewDelegate and DataSource.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation
import UIKit


// MARK: - UITableViewDelegate and UITableViewDataSource extension

extension AllExpensesTableViewController {
    
    // MARK: Table view data source

    // Setup rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return transactions[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AllExpensesCell
        
        guard let cell = cell else { return UITableViewCell() }
        
        cell.backgroundColor = .white
        cell.contentView.backgroundColor = tableView.backgroundColor
        
        let currentTransaction = transactions[indexPath.section][indexPath.row]
        
        cell.configure(transactionModel: currentTransaction)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // Setup sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return transactions.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.boldSystemFont(ofSize: 20)
        
        headerView.addSubview(title)
        
        switch (section) {
        case 0:
            title.text = "Сегодня"
        case 1:
            title.text = "Вчера"
        case 2:
            title.text = "В этом месяце"
        case 3:
            title.text = "Ранее"
        default:
            break
        }
        
        if transactions[section].isEmpty {
            title.text = ""
        }
        
        NSLayoutConstraint.activate([
            title.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5),
            title.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            title.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20)
        ])
        
        headerView.backgroundColor = .white
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if transactions[section].isEmpty {
            return 0
        }
        
        if section == 0 {
            return 60
        }
        
        return 30
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        
        footerView.backgroundColor = .white
        
        return footerView
    }
    
    // MARK: Table view delegate
    
    // select row setup
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentModel = transactions[indexPath.section][indexPath.row]
        presenter?.transactionTapped(model: currentModel)
    }
    
}
