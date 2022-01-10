//
//  AnalyticsInteractorType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation

protocol AnalyticsInteractorType {
    
    var presenter: AnalyticsPresenterType? { get set }
    
    func getCurrentMonthAndYear()
    
    func getAnalyticsData(month: String, year: String, type: CategoryType)
}
