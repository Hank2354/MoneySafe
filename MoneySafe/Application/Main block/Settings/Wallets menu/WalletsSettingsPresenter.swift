//
//  WalletsSettingsPresenter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation
import UIKit

class WalletsSettingsPresenter: WalletsSettingsPresenterType {
    
    var view: WalletsSettingsViewControllerType?
    
    var interactor: WalletsSettingsInteractorType?
    
    var router: WalletsSettingsRouterType?
    
    func isBackButtonPressed() {
        router?.stop()
    }
    
    func isAddWalletButtonPressed() {
        router?.route()
    }
    
    func isWalletsDataFetched(walletModels: [GeneralWalletModel]) {
        
        let sortedWalletModel = walletModels.sorted { $0.walletName < $1.walletName }
        
        view?.update(with: sortedWalletModel)
    }
    
    func isWalletButtonTapped(walletModel: GeneralWalletModel) {
        
        guard let walletMO = walletModel.walletMO else { return }
        
        let actionSheetController = UIAlertController(title: "Что необходимо сделать?", message: nil, preferredStyle: .actionSheet)
        
        let changeNameAction = UIAlertAction(title: "Изменить название", style: .default)  { action in
            
            let alertController = UIAlertController(title: "Введите название", message: nil, preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
                
                let save = self.interactor?.changeWalletName(wallet: walletMO, newName: alertController.textFields!.first!.text!)
                
                switch save {
                case .success(_):
                    self.interactor?.fetchUserWalletsWithCurrentBalance()
                case .failure(let error):
                    
                    switch error {
                        
                    case .incorrectWalletName:
                        
                        let ac = UIAlertController(title: "Ошибка", message: "Имя занято", preferredStyle: .alert)
                        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                        ac.addAction(okButton)
                        self.view?.presentController(alertController: ac)
                        
                    default:
                        
                        return
                        
                    }
                    
                case .none:
                    return
                }
                
                
            }
            
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
            alertController.addTextField { textField in
                
                textField.delegate = (self.view! as! UITextFieldDelegate)
                textField.placeholder = "Название"
                textField.keyboardType = .default
                
            }
            
            self.view?.presentController(alertController: alertController)
        }
        
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive)            { _ in
            
            self.interactor?.disactiveWallet(wallet: walletMO)
            self.interactor?.fetchUserWalletsWithCurrentBalance()
            
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        actionSheetController.addAction(changeNameAction)
        actionSheetController.addAction(deleteAction)
        actionSheetController.addAction(cancelAction)
        
        view?.presentController(alertController: actionSheetController)
        
    }
    
    func updateData() {
        interactor?.fetchUserWalletsWithCurrentBalance()
    }
    
}
