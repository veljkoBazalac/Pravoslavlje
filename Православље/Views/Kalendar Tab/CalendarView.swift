//
//  CalendarView.swift
//  Pravoslavlje
//
//  Created by VELJKO on 28.7.22..
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject private var viewModel : CalendarViewModel
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                VStack(spacing: 20) {
                    CalendarDetailView()
                        .padding(.top, 10)
                }
            }
            Spacer()
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(CalendarViewModel())
    }
}


