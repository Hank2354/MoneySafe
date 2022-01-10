//
//  MainPresenterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 27.12.2021.
//

import Foundation
import UIKit

protocol MainPresenterType {
    
    var view: MainViewControllerType?  { get set }
    
    var interactor: MainInteractorType? { get set }
    
    var router: MainRouterType? { get set }
    
    func functionButtonPressed(_ button: UIButton)
    
    func updateData()
    
    func userDataIsFetched(totalBalance: Decimal?,
                           budgetsWithTransactions: [GeneralActualBudgetModel]?,
                           currentMonth: String?,
                           error: Errors?)
    
}
