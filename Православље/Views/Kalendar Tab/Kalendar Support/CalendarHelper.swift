//
//  CalendarHelper.swift
//  Pravoslavlje
//
//  Created by VELJKO on 28.7.22..
//

import Foundation


class CalendarHelper {
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    func monthString(_ date: Date) -> String {
        dateFormatter.dateFormat = "LLL"
        return dateFormatter.string(from: date)
    }
    
    func yearString(_ date: Date) -> String {
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func plusMonth(_ date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(_ date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    func daysInMonth(_ date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    func dayOfMonth(_ date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func firstOfMonth(_ date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func weekDay(_ date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
}

extension CalendarHelper {
    
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

