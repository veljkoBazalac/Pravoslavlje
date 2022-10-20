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
            VStack(spacing: 20) {
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
    
    // MARK: - Header with Month, Year and Arrow Buttons
    private var header : some View {
        HStack(spacing: 20) {
            // Month and Year Text
            Text(viewModel.getCalendarTitle())
                .font(Font.custom("Clara", size: 35))
            
            Spacer(minLength: 0)
            
            HStack(spacing: 30) {
                // Previous Month Button
                Button {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        viewModel.previousMonth()
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                // Next Month Button
                Button {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        viewModel.nextMonth()
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
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
        LazyVGrid(columns: viewModel.gridColumns, spacing: 0) {
            ForEach(viewModel.getDays()) { value in
                CalendarCell(dayForCell: value)
            }
        }
    }
    
}

// MARK: - Preview
struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(CalendarViewModel())
    }
}


