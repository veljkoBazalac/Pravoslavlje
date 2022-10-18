//
//  CalendarCell.swift
//  Pravoslavlje
//
//  Created by VELJKO on 28.7.22..
//

import SwiftUI

struct CalendarCell: View {
    
    @EnvironmentObject private var viewModel : CalendarViewModel
    @State var dayForCell : DateValue
    
    var body: some View {
        VStack {
            if dayForCell.day != -1 {
                cellDetails
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        
        
//        if count <= 42 {
//
//            if count <= startingSpaces || count - startingSpaces > daysInMonth {
//                Text("")
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//            } else {

//                let day = count - startingSpaces
//                let month = viewModel.monthString(viewModel.date).cyrillicMonths()
//                let monthLetter = viewModel.monthString(viewModel.date).pictureMonthLetter()
                
//                NavigationLink(destination: PraznikView(selectedDay: day,
//                                                        selectedMonth: month,
//                                                        selectedMonthLetter: monthLetter,
//                                                        selectedPraznik: 1)) {
//                    VStack {
//                        Text("\(day)")
//                            .frame(alignment: .top)
//                            .frame(maxWidth: .infinity, maxHeight: 20)
//                            .padding(.top, 5)
//                        Spacer()
//                        if let imageName = viewModel.imageName(day: day, month: month, monthLetter: monthLetter) {
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
    }
    
    // MARK: - Cell Text and Image
    private var cellDetails : some View {
        VStack(alignment: .center, spacing: 4) {
            Text("\(dayForCell.day)")
                .font(Font.custom("Clara", size: 20))
                .padding(.top, 2)
                .padding(.horizontal, 2)
                .background(
                    Color.orange
                        .frame(width: 25)
                        .cornerRadius(4)
                        .padding(.top, 3)
                )
                
            Image("o1.1")
                .resizable()
                .scaledToFit()
        }
        .border(viewModel.getRedDays(value: dayForCell.date) == true ? .red : .clear,
                width: 2)
    }
    
}

struct CalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(CalendarViewModel())
    }
}

