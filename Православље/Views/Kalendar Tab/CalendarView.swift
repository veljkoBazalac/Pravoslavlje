////
////  CalendarView.swift
////  Pravoslavlje
////
////  Created by VELJKO on 28.7.22..
////
//
//import SwiftUI
//
//struct CalendarView: View {
//    
//    @EnvironmentObject var dateHolder: DateHolder
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text("")
//                    .font(Font.custom("CormorantSC-Medium", size: 30))
//                    .navigationTitle("Календар")
//                
//                HStack {
//                    let monthName = CalendarHelper().monthString(dateHolder.date).cyrillicMonths()
//                    let yearNumber = CalendarHelper().yearString(dateHolder.date)
//                    
//                    Button(action: previousMonth) {
//                        Image(systemName: "arrow.left")
//                            .imageScale(.medium)
//                    }
//                    .padding(.trailing, 30)
//                    .disabled(monthName == "Јануар")
//                    Text(monthName)
//                        .font(Font.custom("CormorantSC-Medium", size: 30))
//                        .bold()
//                        .animation(.none)
//                    Text(yearNumber)
//                        .font(Font.custom("CormorantSC-Medium", size: 30))
//                        .bold()
//                        .animation(.none)
//                    Button(action: nextMonth) {
//                        Image(systemName: "arrow.right")
//                            .imageScale(.medium)
//                    }
//                    .padding(.leading, 30)
//                    .disabled(monthName == "Децембар")
//                }
//                .padding(.top, 5)
//
//                dayOfWeekStack
//                calendarGrid
//            }
//        }
//        .navigationViewStyle(.stack)
//    }
//    
//    func previousMonth() {
//        if CalendarHelper().monthString(dateHolder.date).cyrillicMonths() != "Јануар" {
//            dateHolder.date = CalendarHelper().minusMonth(dateHolder.date)
//        }
//    }
//    
//    func nextMonth() {
//        if CalendarHelper().monthString(dateHolder.date).cyrillicMonths() != "Децембар" {
//            dateHolder.date = CalendarHelper().plusMonth(dateHolder.date)
//        }
//    }
//    
//    var dayOfWeekStack: some View {
//        HStack(spacing:1) {
//            Text("Нед").dayOfWeek().foregroundColor(Color.red)
//            Text("Пон").dayOfWeek()
//            Text("Уто").dayOfWeek()
//            Text("Сре").dayOfWeek()
//            Text("Чет").dayOfWeek()
//            Text("Пет").dayOfWeek()
//            Text("Суб").dayOfWeek()
//        }
//    }
//    
//    var calendarGrid: some View {
//        VStack(spacing:1) {
//            
//            let daysInMonth = CalendarHelper().daysInMonth(dateHolder.date)
//            let firstDayOfMonth = CalendarHelper().firstOfMonth(dateHolder.date)
//            let startingSpaces = CalendarHelper().weekDay(firstDayOfMonth)
//            
//            ForEach(0..<6) { row in
//                HStack(spacing: 1) {
//                    ForEach(1..<8) { column in
//                        let count = column + (row * 7)
//                        CalendarCell(count: count, startingSpaces: startingSpaces, daysInMonth: daysInMonth)
//                            .environmentObject(dateHolder)
//                    }
//                }
//            }
//        }
//        .frame(maxHeight: .infinity)
//        
//    }
//    
//}
//
//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}
//
//extension Text {
//    func dayOfWeek() -> some View {
//        self.frame(maxWidth: .infinity)
//            .padding(.top,1)
//            .lineLimit(1)
//    }
//    
//}
