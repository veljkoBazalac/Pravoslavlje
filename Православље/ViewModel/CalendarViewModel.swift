//
//  CalendarViewModel.swift
//  Православље
//
//  Created by VELJKO on 15.10.22..
//

import Foundation
import SwiftUI
import CoreData

final class CalendarViewModel: ObservableObject {
    
    @Published var date : Date = Date()
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    // Current Month selected
    @Published var currentMonth : Int = 0
    // Current Day selected
    @Published var currentDay : Int = 0
    // Current Praznik selected in day
    @Published var currentPraznik : Int = 0
    
    
    // Grid Columns
    let gridColumns = Array(repeating: GridItem(.flexible()), count: 7)
    // Days
    let dayNames: [String] = ["Пон", "Уто", "Сре", "Чет", "Пет", "Суб", "Нед"]
    
    // Show Fasting View
    @Published var showFastingView : Bool = false
    // Show Praznik View
    @Published var showPraznikView : Bool = false
    
    // Months array
    @Published var monthsArray : [MonthEntity] = []
    // All Praznik array data
    @Published var prazniciArray : [PraznikEntity] = []
    // Praznik array data for selected day
    @Published var prazniciInDay : [PraznikEntity] = []
    
    // Get Data from CoreData
    func fetchData() {
        monthsArray = CoreDataManager.shared.getMonthData()
        prazniciArray = CoreDataManager.shared.getPraznikData()
    }
}

// MARK: - Calendar Methods
extension CalendarViewModel {
    
    // MARK: - Get Month Name
    func getMonthName() -> String {
        guard let month = monthsArray[monthNumber() - 1].name else { return "" }
        return month
    }
    
    // MARK: - Get Calendar Title with Month and Year
    func getCalendarTitle() -> String {
        let month = getMonthName()
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
        if monthNumber() >= 2 {
            currentMonth -= 1
        }
    }
    
    // MARK: - Go to Next Month
    func nextMonth() {
        if monthNumber() <= 11 {
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
        
        // Calculate Cell Offset
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
    
    // MARK: - Create Array of PraznikEntity for selected day
    func getPrazniciInDay(day: Int, month: Int) {
        prazniciInDay.removeAll()
        
        let praznici = prazniciArray
            .filter({ $0.monthday == day })
            .sorted(by: { $0.number < $1.number })
        
        if !praznici.isEmpty {
            for praznik in praznici {
                if let praznikMonth = praznik.meseci?.number,
                   praznikMonth == month {
                    prazniciInDay.append(praznik)
                    currentDay = day
                    showPraznikView = true
                }
            }
        } 
    }
    
    // MARK: - Get Praznik selected
    func getPraznik(current: Int) -> PraznikEntity {
        return prazniciInDay[current - 1]
    }
    
    // MARK: - Get About Section for Praznik
    func getPraznikAbout() -> String {
        if
            !prazniciInDay.isEmpty,
            let about = prazniciInDay[currentPraznik].about {
            return about
        } else {
            return ""
        }
    }
    
    // MARK: - Get selected Tag for PageView
    func getTag(number: Int) -> Int {
        return number - 1
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
        return monthNumber
    }
}

// MARK: - Image for Cell
extension CalendarViewModel {
    
    // MARK: - Get Cell Image
    func getCellImage(dayDate: DateValue) -> String? {
        return imageName(day: dayDate.day,
                         month: dayDate.month ,
                         monthLetter: pictureMonthLetter(month: dayDate.month),
                         inDayNumber: 1)
    }
    
    // MARK: - Get image name for days
    func imageName(day: Int, month: Int, monthLetter: String, inDayNumber: Int) -> String? {
        
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
            return "\(monthLetter)\(day).\(inDayNumber)"
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

// MARK: - Praznik Methods
extension CalendarViewModel {
    
    // MARK: - Get Red Days for Calendar
    func getRedDays(date: Date) -> Color {
        
        if dayString(date: date) == "Sunday" {
            return Color.red
        } else {
            
            let month = calendar.component(.month, from: date)
            let day = calendar.component(.day, from: date)
            
            switch month {
                
            // October
            case 10:
                switch day {
                case 27, 31:
                    return Color.red
                default:
                    return Color.clear
                }
                
            // November
            case 11:
                switch day {
                case 8, 21:
                    return Color.red
                default:
                    return Color.clear
                }
            
            // December
            case 12:
                switch day {
                case 4, 19:
                    return Color.red
                default:
                    return Color.clear
                }
            default:
                return Color.clear
            }
        }
    }
    
    // MARK: - Get Fasting Days for Calendar
    func getFastingDays(date: Date) -> Color {
        
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        switch month {
        //
        
        // October
        case 10:
            switch day {
            case 5, 12, 21, 26, 28:
                return Color(K.Colors.voda)
            case 7, 14, 19:
                return Color(K.Colors.ulje)
            default:
                return Color.clear
            }
        // November
        case 11:
            switch day {
            case 2, 4, 9, 11, 18, 23, 28, 30:
                return Color(K.Colors.voda)
            case 16, 25, 29:
                return Color(K.Colors.ulje)
            default:
                return Color.clear
            }
        // December
        case 12:
            switch day {
            case 2, 5, 12, 14, 16, 21, 23, 28:
                return Color(K.Colors.voda)
            case 1, 6, 7, 8, 9, 13, 15, 20, 22, 26, 27, 29, 30, 31:
                return Color(K.Colors.ulje)
            case 3, 4, 10, 11, 17, 18, 19, 24, 25:
                return Color(K.Colors.riba)
            default:
                return Color.clear
            }
        default:
            return Color.clear
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

