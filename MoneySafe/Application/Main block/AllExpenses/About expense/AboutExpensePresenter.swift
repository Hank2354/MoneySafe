//
//  AboutExpensePresenter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation
import UIKit

class AboutExpensePresenter: AboutExpensePresenterType {
    
    var view: AboutExpenseViewControllerType?
    
    var interactor: AboutExpenseInteractorType?
    
    var router: AboutExpenseRouterType?
    
    func saveButtonPressed() {
        
        guard let amountTextField = view?.amountTextField,
              let datePickerView = view?.datePickerView else { return }
        
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
            
            let save = interactor?.saveChanges(walletName: selectedWalletName,
                                               categoryID: selectedCaregoryID,
                                               transactionDetail: transactionDetail,
                                               amount: Decimal(string: _amount)!,
                                               date: datePickerView.date)
            
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
    
    func deleteButtonPressed() {
        
        interactor?.deleteSelectedTransaction()
            
        router?.stop()
            
    }
    
    func userDataWalletsIsFetched(result: Result<[GeneralWalletModel], Errors>) {
        switch result {
            
        case .success(let result):
            
            let selectedWalletName = interactor?.getSelectedTransactionWalletName()

            guard let selectedWalletName = selectedWalletName else { return }
            
            view?.update(with: result)
            
            for (index, walletView) in view!.walletViews.enumerated() {
                if walletView.titleLabel.text! == selectedWalletName {
                    walletView.setActiveStyle()
                    
                    let removedView = view!.walletViews.remove(at: index)
                    view!.walletViews.insert(removedView, at: 0)
                }
            }
            
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
            
            let selectedCategoryID = interactor?.getSelectedCategoryID()

            guard let selectedCategoryID = selectedCategoryID else { return }
            
            view?.update(with: result)
            
            
            for (index, categoryView) in view!.categoryViews.enumerated() {
                if categoryView.categoryID == selectedCategoryID {
                    categoryView.setActiveStyle()
                    
                    let removedView = view!.categoryViews.remove(at: index)
                    view!.categoryViews.insert(removedView, at: 0)
                }
            }
            
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
    
    func transactionDataIsFetched(result: GeneralTransactionModel) {
        view?.update(with: result.amount, descriptionText: result.descriptionText, date: result.date)
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
