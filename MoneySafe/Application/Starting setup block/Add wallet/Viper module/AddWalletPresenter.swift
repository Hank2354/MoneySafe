//
//  AddWalletPresenter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 19.12.2021.
//

import Foundation

class AddWalletPresenter: AddWalletPresenterType {
    
    var interactor: AddWalletInteractorType?
    
    var router: AddWalletRouterType?
    
    var view: AddWalletViewControllerType?
    
    var cashWallet: GeneralWalletModel?
    
    func isContinueButtonPressed() {
        
        let cashCount = view?.moneyCountTextField.text?.cancelMoneyStylePattern()
        let walletName = view?.walletNameTextField.text
        
        guard let cashCount = cashCount,
              let walletName = walletName,
                  walletName != "" else { return }
       

        let wallet = interactor?.createWallet(withName: walletName, cashCount: cashCount)
        
        guard let wallet = wallet else { return }
        
        if let cashWallet = cashWallet {
            router?.route(with: [cashWallet, wallet])
        } else {
            router?.route(with: [wallet])
        }
        
    }
    
    func isSkipButtonPressed() {
        
        if let cashWallet = cashWallet {
            router?.route(with: [cashWallet])
        } else {
            view?.presentWarnMessage(with: "Вам необходимо создать хотя бы один кошелек, или добавить наличные, чтобы продолжить")
        }
        
        
        
    }
    
    func isBackButtonPressed() {
        router?.stop()
    }
}
