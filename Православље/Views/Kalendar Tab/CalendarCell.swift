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
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Cell Text and Image
    private var cellDetails : some View {
        VStack(alignment: .center, spacing: 5) {
            // Cell Number
            Text("\(dayForCell.day)")
                .font(Font.custom(K.Fonts.clara, size: 20))
                .foregroundColor(Color(K.Colors.textColor))
                .padding(.top, 2)
                .padding(.horizontal, 2)
                .background(
                    viewModel.getFastingDays(date: dayForCell.date)
                        .frame(width: 25)
                        .cornerRadius(4)
                        .padding(.top, 3)
                )
            // Cell Image
            if let imageName = viewModel.getCellImage(dayDate: dayForCell) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(5)
                    .frame(maxWidth: .infinity, maxHeight: 60)
            }
        }
        
        // Cell Border for Red Days
        .border(viewModel.getRedDays(date: dayForCell.date),
                width: 2)
        .cornerRadius(2)
    }
}

// MARK: - Preview
struct CalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(CalendarViewModel())
    }
}

