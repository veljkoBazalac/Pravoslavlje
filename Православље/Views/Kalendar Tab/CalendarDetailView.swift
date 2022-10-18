//
//  CustomDatePicker.swift
//  Православље
//
//  Created by VELJKO on 16.10.22..
//

import SwiftUI

struct CalendarDetailView: View {
    
    @EnvironmentObject private var viewModel : CalendarViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 35) {
                header
                dayNames
                calendarGrid
            }
        }
        .onChange(of: viewModel.currentMonth) { newValue in
            viewModel.date = viewModel.getCurrentMonth()
        }
    }
}

extension CalendarDetailView {
    
    // MARK: - Header with Year, Month and Arrow Buttons
    private var header : some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text(viewModel.yearString())
                    .font(Font.custom("Clara", size: 20))
                
                Text(viewModel.monthString().cyrillicMonths())
                    .font(Font.custom("Clara", size: 40))
            }
            
            Spacer(minLength: 0)
            
            Button {
                withAnimation(.easeInOut(duration: 0.1)) {
                    viewModel.previousMonth()
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
            }
            
            Button {
                withAnimation(.easeInOut(duration: 0.1)) {
                    viewModel.nextMonth()
                }
            } label: {
                Image(systemName: "chevron.right")
                    .font(.title2)
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Day Names
    private var dayNames : some View {
        HStack(spacing: 0) {
            ForEach(viewModel.dayNames, id: \.self) { day in
                Text(day)
                    .font(Font.custom("Clara", size: 20))
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    // MARK: - Calendar Grid
    private var calendarGrid : some View {
        LazyVGrid(columns: viewModel.gridColumns) {
            ForEach(viewModel.extractDate()) { value in
                CalendarCell(dayForCell: value)
            }
        }
    }
    
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(CalendarViewModel())
    }
}


