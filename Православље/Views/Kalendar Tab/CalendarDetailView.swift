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
                Spacer()
            }
        }
        .onChange(of: viewModel.currentMonth) { newValue in
            viewModel.date = viewModel.getCurrentMonth()
        }
        .sheet(isPresented: $viewModel.showPraznikView) {
            PraznikView()
        }
    }
}

extension CalendarDetailView {
    
    // MARK: - Header with Month, Year and Arrow Buttons
    private var header : some View {
        HStack(spacing: 20) {
            // Month and Year Text
            Text(viewModel.getCalendarTitle())
                .font(Font.custom(K.Fonts.clara, size: 35))
                .foregroundColor(Color(K.Colors.textColor))
            
            Spacer(minLength: 0)
            
            HStack(spacing: 30) {
                // Previous Month Button
                Button {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        viewModel.previousMonth()
                    }
                } label: {
                    Image(systemName: K.Images.chevronLeft)
                        .font(.title2)
                        .foregroundColor(Color(K.Colors.textColor))
                }
                // Next Month Button
                Button {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        viewModel.nextMonth()
                    }
                } label: {
                    Image(systemName: K.Images.chevronRight)
                        .font(.title2)
                        .foregroundColor(Color(K.Colors.textColor))
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
                    .font(Font.custom(K.Fonts.clara, size: 20))
                    .foregroundColor(Color(K.Colors.textColor))
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    // MARK: - Calendar Grid
    private var calendarGrid : some View {
        LazyVGrid(columns: viewModel.gridColumns, spacing: 8) {
            ForEach(viewModel.getDays()) { value in
                CalendarCell(dayForCell: value)
                    .onTapGesture {
                        viewModel.getPrazniciInDay(day: value.day, month: value.month)
                    }
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


