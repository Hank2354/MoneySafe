//
//  NewIncomePresenter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 27.12.2021.
//

import Foundation
import UIKit

class NewIncomePresenter: NewIncomePresenterType {
    
    var view: NewIncomeViewControllerType?
    
    var interactor: NewIncomeInteractorType?
    
    var router:NewIncomeRouterType?
    
    func saveButtonPressed() {
        
        guard let amountTextField = view?.amountTextField else { return }
        
        if amountTextField.text == "" || amountTextField.text == nil {
            
            let ac = UIAlertController(title: "Введите сумму", message: "Вам необходимо указать сумму операции", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Понял", style: .default, handler: nil)
            ac.addAction(okButton)
            
            view?.presentWarnMessage(alertController: ac)
            
        } else {
            
            var selectedCaregoryID: String = ""
            var selectedWalletName: String = ""
            let transactionDetail = view?.desctiptionTextField.text
            let amount = view?.amountTextField.text?.cancelMoneyStylePattern()
            
            guard let categoryViews = view?.categoryViews,
                  let walletViews = view?.walletViews,
                  let amount = amount else { return }
            
            for categoryView in categoryViews {
                
                if categoryView.isActive {
                    
                    selectedCaregoryID = categoryView.categoryID
                    
                }
                
            }
            
            for walletView in walletViews {
                
                if walletView.isActive {
                    
                    guard let walletName = walletView.titleLabel.text else { return }
                    
                    selectedWalletName = walletName
                    
                }
                
            }
            
            let _amount = amount.replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)
            
            let save = interactor?.saveTransaction(walletName: selectedWalletName,
                                        categoryID: selectedCaregoryID,
                                        transactionDetail: transactionDetail,
                                        amount: Decimal(string: _amount)!)
            
            switch save {
            
            case .success(_):
                
                router?.stop()
                
            case .failure(let error):
                
                let title = "Ошибка сохранения"
                
                var message: String?
                
                switch error {
                    
                case .loadTransactionsError:
                    
                     message = "Возникла ошибка при сохранении транзакции"
                    
                case .loadWalletsError:
                    
                     message = "Возникла ошибка при сохранении кошелька"
                    
                case .loadUserSettingsError:
                    
                     message = "Возникла ошибка при сохранении пользовательских настроек"
                    
                case .loadUserBudgetsError:
                    
                     message = "Возникла ошибка при сохранении бюджетов"
                    
                default:
                    return
                    
                }
                
                let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Понял", style: .default, handler: nil)
                ac.addAction(okButton)
                
                view?.presentWarnMessage(alertController: ac)
                
            case .none:
                return
            }
            
        }
        
    }
    
    func backButtonPressed() {
        router?.stop()
    }
    
    func userDataWalletsIsFetched(result: Result<[GeneralWalletModel], Errors>) {
        switch result {
            
        case .success(let result):
            
            view?.update(with: result)
            
        case .failure(let error):
            
            let title = "Ошибка загрузки данных"
            
            var message: String?
            
            switch error {
                
            case .loadTransactionsError:
                
                 message = "Возникла ошибка при загрузке транзакций"
                
            case .loadWalletsError:
                
                 message = "Возникла ошибка при загрузке кошельков"
                
            case .loadUserSettingsError:
                
                 message = "Возникла ошибка при загрузке пользовательских настроек"
                
            case .loadUserBudgetsError:
                
                 message = "Возникла ошибка при загрузке бюджетов"
                
            default:
                return
                
            }
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Понял", style: .default, handler: nil)
            ac.addAction(okButton)
            
            view?.presentWarnMessage(alertController: ac)
            
        }
    }
    
    func userDataCategoriesIsFetched(result: Result<[GeneralCategoryModel], Errors>) {
        switch result {
            
        case .success(let result):
            
            view?.update(with: result)
            
        case .failure(let error):
            
            let title = "Ошибка загрузки данных"
            
            var message: String?
            
            switch error {
                
            case .loadTransactionsError:
                
                 message = "Возникла ошибка при загрузке транзакций"
                
            case .loadWalletsError:
                
                 message = "Возникла ошибка при загрузке кошельков"
                
            case .loadUserSettingsError:
                
                 message = "Возникла ошибка при загрузке пользовательских настроек"
                
            case .loadUserBudgetsError:
                
                 message = "Возникла ошибка при загрузке бюджетов"
                
            default:
                return
            }
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Понял", style: .default, handler: nil)
            ac.addAction(okButton)
            
            view?.presentWarnMessage(alertController: ac)
            
        }
    }
    
    func changeCategoryViewStatus(tappedView: CategoryView) {
        
        guard let categoryViews = view?.categoryViews else { return }
        
        for categoryView in categoryViews {
            categoryView.isActive = false
            categoryView.setDefaultStyle()
        }
        
        if !tappedView.isActive {
            tappedView.setActiveStyle()
        }
    }
    
    func changeWalletViewStatus(tappedView: WalletView) {
        
        guard let walletViews = view?.walletViews else { return }
        
        for walletView in walletViews {
            walletView.isActive = false
            walletView.setDefaultStyle()
        }
        
        if !tappedView.isActive {
            tappedView.setActiveStyle()
        }
        
    }
}
