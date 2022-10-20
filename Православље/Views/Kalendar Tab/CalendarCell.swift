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
        .padding(8)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Cell Text and Image
    private var cellDetails : some View {
        VStack(alignment: .center, spacing: 5) {
            // Cell Number
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
            // Cell Image
            if let imageName = viewModel.getCellImage(dayDate: dayForCell) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 60)
            }
        }
        // Cell Border for Red Days
        .border(viewModel.getRedDays(date: dayForCell.date) == true ? .red : .clear,
                width: 2)
    }
}

// MARK: - Preview
struct CalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(CalendarViewModel())
    }
}

