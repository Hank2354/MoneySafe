//
//  AnalyticsPresenterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation

protocol AnalyticsPresenterType {
    
    var view: AnalyticsViewControllerType? { get set }
    
    var interactor: AnalyticsInteractorType? { get set }
    
    var router: AnalyticsRouterType? { get set }
    
    func currentMonthAndYearFethed(month: String, year: String)
    
    func analyticsDataIsFethed(pieData: GeneralMainAnalyticsModel?,
                               barData: GeneralBarAnalyticsModel?,
                               budgetModel: GeneralActualBudgetModel?,
                               error: Errors?)
    
    func backButtonPressed()
    
    func updateCharts(type: CategoryType)
}
