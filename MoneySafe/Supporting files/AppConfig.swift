//
//  AppConfig.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 25.12.2021.
//

import Foundation

let incomeCategories: [GeneralCategoryModel] = [
    GeneralCategoryModel(categoryName: "Зарплата",
                         icon: .logoSalary,       categoryType: .income,  categoryID: "0_1", color: .greenCategoryColor),
    
    GeneralCategoryModel(categoryName: "Прочие доходы",
                         icon: .logoSomeIncomes,  categoryType: .income,  categoryID: "0_2", color: .blueCategoryColor),
    
    GeneralCategoryModel(categoryName: "Инвестиции",
                         icon: .logoInvestitions, categoryType: .income,  categoryID: "0_3", color: .orangeYellowCategoryColor),
    
    GeneralCategoryModel(categoryName: "Подарки",
                         icon: .logoGift,         categoryType: .income,  categoryID: "0_4", color: .purpleCategoryColor)
]

let expenseCaregories: [GeneralCategoryModel] = [
    GeneralCategoryModel(categoryName: "Продукты",
                         icon: .logoPoducts,      categoryType: .expense, categoryID: "1_1", color: .redCategoryColor),
    
    GeneralCategoryModel(categoryName: "Бизнес",
                         icon: .logoBusiness,     categoryType: .expense, categoryID: "1_2", color: .darkBlueCategoryColor),
    
    GeneralCategoryModel(categoryName: "Видеоигры",
                         icon: .logoGames,        categoryType: .expense, categoryID: "1_3", color: .lightOrangeCategoryColor),
    
    GeneralCategoryModel(categoryName: "Прочие расходы",
                         icon: .logoSomeExpenses, categoryType: .expense, categoryID: "1_4", color: .cyanCategoryColor),
    
    GeneralCategoryModel(categoryName: "Услуги",
                         icon: .logoServices,     categoryType: .expense, categoryID: "1_5", color: .salatCategoryColor),
    
    GeneralCategoryModel(categoryName: "Автомобиль",
                         icon: .logoVechile,      categoryType: .expense, categoryID: "1_6", color: .blueCategoryColor),
    
    GeneralCategoryModel(categoryName: "Лекарства",
                         icon: .logoMedications,  categoryType: .expense, categoryID: "1_7", color: .greenCategoryColor),
    
    GeneralCategoryModel(categoryName: "Подарки",
                         icon: .logoGift,         categoryType: .expense, categoryID: "1_8", color: .purpleCategoryColor),
    
    GeneralCategoryModel(categoryName: "Кредиты",
                         icon: .logoCredits,      categoryType: .expense, categoryID: "1_9", color: .violetCategoryColor),
    
    GeneralCategoryModel(categoryName: "Развлечения",
                         icon: .logoEntertaiment, categoryType: .expense, categoryID: "1_10", color: .lightCyanCategoryColor),
    
    GeneralCategoryModel(categoryName: "Красота",
                         icon: .logoBeauty,       categoryType: .expense, categoryID: "1_11", color: .lightRedCategoryColor),
    
    GeneralCategoryModel(categoryName: "Здоровье",
                         icon: .logoMedical,      categoryType: .expense, categoryID: "1_12", color: .highRedCategoryColor),
    
    GeneralCategoryModel(categoryName: "Ребенок",
                         icon: .logoBaby,         categoryType: .expense, categoryID: "1_13", color: .purpleBlueCategoryColor),
    
    GeneralCategoryModel(categoryName: "Спорт",
                         icon: .logoSport,        categoryType: .expense, categoryID: "1_14", color: .lightBlueCategoryColor),
    
    GeneralCategoryModel(categoryName: "Рестораны",
                         icon: .logoRest,         categoryType: .expense, categoryID: "1_15", color: .orangeCategoryColor),
    
    GeneralCategoryModel(categoryName: "Коммунальные расходы",
                         icon: .logoHouse,        categoryType: .expense, categoryID: "1_16", color: .highGreenCategoryColor),
    
    GeneralCategoryModel(categoryName: "Интернет",
                         icon: .logoWeb,          categoryType: .expense, categoryID: "1_17", color: .highPurpleCategoryColor),
    
    GeneralCategoryModel(categoryName: "Одежда",
                         icon: .logoWear,         categoryType: .expense, categoryID: "1_18", color: .yellowCategoryColor),
    
    GeneralCategoryModel(categoryName: "Общественный транспорт",
                         icon: .logoBus,          categoryType: .expense, categoryID: "1_19", color: .orangeYellowCategoryColor),
    
    GeneralCategoryModel(categoryName: "Путешествия",
                         icon: .logoPlane,        categoryType: .expense, categoryID: "1_20", color: .darpPurpleCategoryColor),
    
    GeneralCategoryModel(categoryName: "Кино",
                         icon: .logoMovie,        categoryType: .expense, categoryID: "1_21", color: .extraCyanCategoryColor),
    
    GeneralCategoryModel(categoryName: "Ремонт",
                         icon: .logoStairs,       categoryType: .expense, categoryID: "1_22", color: .skyCategoryColor),
    
]

func getCategoryFromID(id: String) -> GeneralCategoryModel? {
    
    var currentCategory: GeneralCategoryModel?
    
    if id.isExpenseCategoryID() {
        
        for category in expenseCaregories {
            
            if id == category.categoryID {
                
                currentCategory = category
                
            }
            
        }
        
        return currentCategory
        
    } else {
        
        for category in incomeCategories {
            
            if id == category.categoryID {
                
                currentCategory = category
                
            }
            
        }
        
        return currentCategory
        
    }
    
}
