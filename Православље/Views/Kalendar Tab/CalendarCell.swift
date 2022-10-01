////
////  CalendarCell.swift
////  Pravoslavlje
////
////  Created by VELJKO on 28.7.22..
////
//
//import SwiftUI
//
//struct CalendarCell_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarCell(count: 1, startingSpaces: 1, daysInMonth: 1)
//    }
//}
//
//struct CalendarCell: View {
//    
//    @EnvironmentObject var dateHolder: DateHolder
//    let count : Int
//    let startingSpaces : Int
//    let daysInMonth : Int
//    
//    var body: some View {
//        
//        if count <= 42 {
//            
//            if count <= startingSpaces || count - startingSpaces > daysInMonth {
//                Text("")
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//            } else {
//
//                let day = count - startingSpaces
//                let month = CalendarHelper().monthString(dateHolder.date).cyrillicMonths()
//                let monthLetter = CalendarHelper().monthString(dateHolder.date).pictureMonthLetter()
//                
//                NavigationLink(destination: PraznikView(selectedDay: day, selectedMonth: month, selectedMonthLetter: monthLetter, selectedPraznik: 1)) {
//                    VStack {
//                        Text("\(day)")
//                            .frame(alignment: .top)
//                            .frame(maxWidth: .infinity, maxHeight: 20)
//                            .padding(.top, 5)
//                        Spacer()
//                        if let imageName = CalendarHelper().imageName(day: day, month: month, monthLetter: monthLetter) {
//                            Image(imageName)
//                                .resizable()
//                                .frame(maxHeight: .infinity)
//                                .aspectRatio(contentMode: .fit)
//                        }
//                        Spacer()
//                    }
//                    .frame(maxHeight: .infinity)
//                    .border(.red, width: 2)
//                }
//            }
//        }
//    }
//}
//
//
