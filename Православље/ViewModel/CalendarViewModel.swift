//
//  CalendarViewModel.swift
//  Православље
//
//  Created by VELJKO on 15.10.22..
//

import Foundation
import SwiftUI

final class CalendarViewModel: ObservableObject {
    
    @Published var date : Date = Date()
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    // Current Month selected
    @Published var currentMonth : Int = 0
    
    // Grid Columns
    let gridColumns = Array(repeating: GridItem(.flexible()), count: 7)
    // Days
    let dayNames: [String] = ["Пон", "Уто", "Сре", "Чет", "Пет", "Суб", "Нед"]
    
    // Show Fasting View
    @Published var showFastingView : Bool = false
    
    // All Eparhije Data
    @Published var monthArray : [MonthEntity] = []
    
    @Published var praznikArray : [PraznikEntity] = []
    
    func fetchData() {
        monthArray = CoreDataManager.shared.getMonthData()
        praznikArray = CoreDataManager.shared.getPraznikData()
    }
}

// MARK: - Calendar Methods
extension CalendarViewModel {
    
    // MARK: - Get Month and Year Title
    func getCalendarTitle() -> String {
        guard let month = monthArray[monthNumber()].name else { return "" }
        let year = yearString()
        return "\(month) \(year)"
    }
    
    
    // MARK: - Get Current Month
    func getCurrentMonth() -> Date {
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    
    // MARK: - Go to Previous Month
    func previousMonth() {
        if monthString().cyrillicMonths() != "Јануар" {
            currentMonth -= 1
        }
    }
    
    // MARK: - Go to Next Month
    func nextMonth() {
        if monthString().cyrillicMonths() != "Децембар" {
            currentMonth += 1
        }
    }
    
    // MARK: - Get Array of Days from Date
    func getDays() -> [DateValue] {
        
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            let month = calendar.component(.month, from: date)
            return DateValue(day: day, month: month, date: date)
        }
        
        let firstWeekDay = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        // Calculate Offset
        if firstWeekDay != 1 {
            // Empty Cells at the beginning
            for _ in 0..<(firstWeekDay - 2) {
                days.insert(DateValue(day: -1, month: 0, date: Date()), at: 0)
            }
            
        } else {
            // Empty Cells at the beginning if first day is Sunday
            for _ in 0..<(firstWeekDay + 5) {
                days.insert(DateValue(day: -1, month: 0, date: Date()), at: 0)
            }
        }
        
        return days
    }
    
    // MARK: - Get Red Days
    func getRedDays(date: Date) -> Bool {
        
        if dayString(date: date) == "Sunday" {
            return true
        } else {
            
            let day = calendar.component(.day, from: date)
            let month = calendar.component(.month, from: date)
            
            switch month {
            case 10:
                if day == 27 || day == 31 {
                    return true
                }
            default:
                return false
            }
            
            return false
        }
    }
    
    
}

// MARK: - Calendar Format
extension CalendarViewModel {
    
    func dayNumber(date: Date) -> Int {
        let day = calendar.component(.day, from: date)
        return day
    }
    
    // MARK: - Get Month String
    func monthString() -> String {
        dateFormatter.dateFormat = "LLL"
        return dateFormatter.string(from: date)
    }
    
    // MARK: - Get Year String
    func yearString() -> String {
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    // MARK: - Get Day String
    func dayString(date: Date) -> String {
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    // MARK: - Get Month Number
    func monthNumber() -> Int {
        let monthNumber = calendar.component(.month, from: date)
        return monthNumber - 1
    }
}

// MARK: - Image for Cell
extension CalendarViewModel {
    
    // MARK: - Get Cell Image
    func getCellImage(dayDate: DateValue) -> String? {
        return imageName(day: dayDate.day,
                         month: dayDate.month ,
                         monthLetter: pictureMonthLetter(month: dayDate.month))
    }
    
    // MARK: - Get image name for days
    func imageName(day: Int, month: Int, monthLetter: String) -> String? {
        
        if day == 21 && month == 4 {
            return "tajnaVecera"
        } else if day == 16 && month == 4 {
            return "lazarevaSubota"
        } else if day == 17 && month == 4 {
            return "cveti"
        } else if day == 22 && month == 4 {
            return "velikiPetak"
        } else if day == 23 && month == 4 {
            return "velikaSubota"
        } else if day == 24 && month == 4 {
            return "vaskrs"
        } else if day == 25 && month == 4 {
            return "vaskrsniPonedeljak"
        } else if day == 26 && month == 4 {
            return "vaskrsniUtorak"
        } else if day == 2 && month == 6 {
            return "Spasovdan"
        } else if day == 12 && month == 6 {
            return "Trojice"
        } else if day == 13 && month == 6 {
            return "DuhovskiPonedeljak"
        } else if day == 14 && month == 6 {
            return "DuhovskiUtorak"
        } else if day == 31 && (month == 4 || month == 6 || month == 9 || month == 11) {
            return nil
        } else if (day == 29 || day == 30 || day == 31) && month == 2 {
            return nil
        } else {
            return "\(monthLetter)\(day).1"
        }
    }
    
    
    // MARK: - Get First letters for Image Names
    func pictureMonthLetter(month: Int) -> String {
        switch month {
        case 1:
            return "ja"
        case 2:
            return "f"
        case 3:
            return "m"
        case 4:
            return "a"
        case 5:
            return "mj"
        case 6:
            return "jn"
        case 7:
            return "jl"
        case 8:
            return "av"
        case 9:
            return "s"
        case 10:
            return "o"
        case 11:
            return "n"
        case 12:
            return "d"
        default:
            return ""
        }
    }
}

// MARK: - Date Extension
extension Date {
    func getAllDates() -> [Date] {
        
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day,
                                 value: day - 1,
                                 to: startDate)!
        }
    }
}

// MARK: - String Extension
extension String {
    
    // MARK: - Get Cyrillic Month Names
    func cyrillicMonths() -> String {
        switch self {
        case "Jan":
            return "Јануар"
        case "Feb":
            return "Фебруар"
        case "Mar":
            return "Март"
        case "Apr":
            return "Април"
        case "May":
            return "Мај"
        case "Jun":
            return "Јун"
        case "Jul":
            return "Јул"
        case "Aug":
            return "Август"
        case "Sep":
            return "Септембар"
        case "Oct":
            return "Октобар"
        case "Nov":
            return "Новембар"
        case "Dec":
            return "Децембар"
        default:
            return ""
        }
    }
    
}
