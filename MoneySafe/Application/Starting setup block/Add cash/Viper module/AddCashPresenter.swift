//
//  Presenter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 19.12.2021.
//

import Foundation

class AddCashPresenter: AddCashPresenterType {
    
    var interactor: AddCashInteractorType?
    
    var router: AddCashRouterType?
    
    var view: AddCashViewControllerType?
    
    func isContinueButtonPressed()  {
        
        let cashCount = view?.moneyTextField.text?.cancelMoneyStylePattern()
        
        guard let cashCount = cashCount else { return }
        
        let wallet = interactor?.createWallet(cashCount: cashCount)
        
        router?.route(with: wallet)
    }
    
    func isSkipButtonPressed()      {
        
        router?.route(with: nil)
    }
    
}
