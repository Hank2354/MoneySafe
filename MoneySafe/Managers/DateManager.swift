//
//  DateHelper.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 29.12.2021.
//

import Foundation

class DateManager {
    
    // Singleton
    static let shared = DateManager()
    private init() {}
    
    // 12 months
    let dateMap: [String: String] = [
        "1" : "Январь",   "01": "Январь",
        "2" : "Февраль",  "02": "Февраль",
        "3" : "Март",     "03": "Март",
        "4" : "Апрель",   "04": "Апрель",
        "5" : "Май",      "05": "Май",
        "6" : "Июнь",     "06": "Июнь",
        "7" : "Июль",     "07": "Июль",
        "8" : "Август",   "08": "Август",
        "9" : "Сентябрь", "09": "Сентябрь",
        "10": "Октябрь",
        "11": "Ноябрь",
        "12": "Декабрь"
    ]
    
    let dateMapInt: [Int: String] = [
        1  : "Январь",
        2  : "Февраль",
        3  : "Март",
        4  : "Апрель",
        5  : "Май",
        6  : "Июнь",
        7  : "Июль",
        8  : "Август",
        9  : "Сентябрь",
        10 : "Октябрь",
        11 : "Ноябрь",
        12 : "Декабрь",
        
    ]
    
    
    // 31 days
    let days: [String] = [
        "01", "02", "03", "04", "05", "06", "07",
        "08", "09", "10", "11", "12", "13", "14",
        "15", "16", "17", "18", "19", "20", "21",
        "22", "23", "24", "25", "26", "27", "28",
        "29", "30", "31"
    ]
    
    func getDateModel(_ date: Date?) -> GeneralDate {
        
        if let date = date {
            let separatedDate = date.description.split(separator: " ")[0].split(separator: "-")
            
            let year: String = String(separatedDate[0])
            let month: String = String(separatedDate[1])
            let day: String = String(separatedDate[2])
            
            return GeneralDate(day: day, mouth: month, year: year)
        } else {
            
            let separatedDate = Date().description.split(separator: " ")[0].split(separator: "-")
            
            let year: String = String(separatedDate[0])
            let month: String = String(separatedDate[1])
            let day: String = String(separatedDate[2])

            return GeneralDate(day: day, mouth: month, year: year)
        }

        
    }
    
    func getMonthString(_ date: Date?) -> String {
        
        if let date = date {
            let currentDate = getDateModel(date)
            return dateMap[currentDate.mouth] ?? "Unknow"
        } else {
            let currentDate = getDateModel(nil)
            return dateMap[currentDate.mouth] ?? "Unknow"
        }
        
    }
    
    func getYearString(_ date: Date?) -> String {
        
        if let date = date {
            let currentDate = getDateModel(date)
            return currentDate.year 
        } else {
            let currentDate = getDateModel(nil)
            return currentDate.year 
        }
        
    }
    
    func getTomorrowDate(_ date: Date?) -> GeneralDate {
        
        let currentDate = date ?? Date()

        let yesterdayDate = currentDate - (60*60*24)
        
        let yesterdayCurrentDate = getDateModel(yesterdayDate)
        
        return yesterdayCurrentDate
    }
    
    func getFormattedDate(_ date: Date?) -> String {
        
        if let date = date {
            
            let currentDate = getDateModel(date)
            
            return "\(currentDate.day).\(currentDate.mouth).\(currentDate.year)"
            
        } else {
            
            let nowDate = getDateModel(Date())
            
            return "\(nowDate.day).\(nowDate.mouth).\(nowDate.year)"
            
        }
        
    }
    
    
}
