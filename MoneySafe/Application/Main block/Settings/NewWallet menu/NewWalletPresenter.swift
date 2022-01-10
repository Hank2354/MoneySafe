//
//  NewWalletPresenter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 02.01.2022.
//

import Foundation
import UIKit

class NewWalletPresenter: NewWalletPresenterType {
    
    var view: NewWalletViewControllerType?
    
    var interactor: NewWalletInteractorType?
    
    var router: NewWalletRouterType?
    
    func saveButtonPressed() {
        guard let walletName = view?.desctiptionTextField.text,
              let startBalanceString = view?.amountTextField.text?.cancelMoneyStylePattern(),
              startBalanceString != "",
              walletName != "" else {
                  
                  let ac = createAlertController(title: "Не все поля заполнены", message: "Необходимо указать баланс и название")
                  
                  view?.presentWarnMessage(alertController: ac)
                  
                  return
              }
        
        let _startBalanceString = startBalanceString.replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)
        
        let save = interactor?.saveWallet(walletName: walletName, startBalance: Decimal(string: _startBalanceString)!)
        
        switch save {
            
        case .success(_):
            
            router?.stop()
            
        case .failure(_):
            
            let ac = createAlertController(title: "Ошибка", message: "Ошибка сохранения")
            
            view?.presentWarnMessage(alertController: ac)
            
        case .none:
            return
        }
    }
    
    func backButtonPressed() {
        router?.stop()
    }
    
    func createAlertController(title: String?, message: String?) -> UIAlertController {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        ac.addAction(okButton)
        
        return ac
        
    }
    
    
}
