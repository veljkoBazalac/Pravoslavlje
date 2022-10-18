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
    
    // Current Month selected - 0 is current Month in time
    @Published var currentMonth : Int = 0
    
    // Grid Columns
    let gridColumns = Array(repeating: GridItem(.flexible()), count: 7)
    // Days
    let dayNames: [String] = ["Пон", "Уто", "Сре", "Чет", "Пет", "Суб", "Нед"]
    
    
    
}

// MARK: - Calendar Methods
extension CalendarViewModel {
    
    // Get Current Month
    func getCurrentMonth() -> Date {
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    
    // Go to Previous Month
    func previousMonth() {
        if monthString().cyrillicMonths() != "Јануар" {
            currentMonth -= 1
        }
    }
    
    // Go to Next Month
    func nextMonth() {
        if monthString().cyrillicMonths() != "Децембар" {
            currentMonth += 1
        }
    }
    
    // Get Array of Days from Date
    func extractDate() -> [DateValue] {
        
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        let firstWeekDay = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        // Calculate Offset
        if firstWeekDay != 1 {
            // Empty Cells at the beginning
            for _ in 0..<(firstWeekDay - 2) {
                days.insert(DateValue(day: -1, date: Date()), at: 0)
            }
            
        } else {
            // Empty Cells at the beginning if first day is Sunday
            for _ in 0..<(firstWeekDay + 5) {
                days.insert(DateValue(day: -1, date: Date()), at: 0)
            }
        }
        
        return days
    }
    
    // Get Red Days
    func getRedDays(value: Date) -> Bool {
        
        if dayString(date: value) == "Sunday" {
            return true
        } else {
            return false
        }
    }
    
}

// MARK: - Calendar Format
extension CalendarViewModel {
    
    // Get Month String
    func monthString() -> String {
        dateFormatter.dateFormat = "LLL"
        return dateFormatter.string(from: date)
    }
    
    // Get Year String
    func yearString() -> String {
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    // Get Day String
    func dayString(date: Date) -> String {
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
}

// MARK: - Image Name
extension CalendarViewModel {
    
    func imageName(day: Int, month: String, monthLetter: String) -> String? {
        
        if day == 21 && month == "Април" {
            return "tajnaVecera"
        } else if day == 16 && month == "Април" {
            return "lazarevaSubota"
        } else if day == 17 && month == "Април" {
            return "cveti"
        } else if day == 22 && month == "Април" {
            return "velikiPetak"
        } else if day == 23 && month == "Април" {
            return "velikaSubota"
        } else if day == 24 && month == "Април" {
            return "vaskrs"
        } else if day == 25 && month == "Април" {
            return "vaskrsniPonedeljak"
        } else if day == 26 && month == "Април" {
            return "vaskrsniUtorak"
        } else if day == 2 && month == "Јун" {
            return "Spasovdan"
        } else if day == 12 && month == "Јун" {
            return "Trojice"
        } else if day == 13 && month == "Јун" {
            return "DuhovskiPonedeljak"
        } else if day == 14 && month == "Јун" {
            return "DuhovskiUtorak"
        } else if day == 31 && (month == "Април" || month == "Јун" || month == "Септембар" || month == "Новембар" || month == "Фебруар") {
            return nil
        } else if (day == 29 || day == 30) && month == "Фебруар" {
            return nil
        } else {
            return "\(monthLetter)\(day).1"
        }
    }
}

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

// MARK: - Text Extension
extension Text {
    func dayOfWeek() -> some View {
        self.frame(maxWidth: .infinity)
            .padding(.top,1)
            .lineLimit(1)
    }
}

// MARK: - String Extension
extension String {
    
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
    
    func pictureMonthLetter() -> String {
        switch self {
        case "Jan":
            return "ja"
        case "Feb":
            return "f"
        case "Mar":
            return "m"
        case "Apr":
            return "a"
        case "May":
            return "mj"
        case "Jun":
            return "jn"
        case "Jul":
            return "jl"
        case "Aug":
            return "av"
        case "Sep":
            return "s"
        case "Oct":
            return "o"
        case "Nov":
            return "n"
        case "Dec":
            return "d"
        default:
            return ""
        }
    }
}
