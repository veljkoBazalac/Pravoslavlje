//
//  CalendarView.swift
//  Pravoslavlje
//
//  Created by VELJKO on 28.7.22..
//

import SwiftUI

// MARK: - Calendar with Dates and Fasting Rules
struct CalendarView: View {
    
    @EnvironmentObject private var viewModel : CalendarViewModel
    @Environment(\.dismiss) private var dismissView
    
    @State private var showView : Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center) {
                    ArrowDownButton()
                    Spacer()
                    infoButton
                }
                calendarDetailView
            }
            FastingView(showView: $showView)
        }
        .background(
            backgroundGradiant()
        )
    }
}

extension CalendarView {
    
    // MARK: - Info Button
    private var infoButton : some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                self.showView.toggle()
            }
        } label: {
            Image(systemName: K.Images.infoCircle)
                .font(.title2)
                .foregroundColor(Color(K.Colors.textColor))
                .padding(.trailing, 15)
        }
    }
    
    // MARK: - Calendar Detail View
    private var calendarDetailView : some View {
        ZStack(alignment: .top) {
            CalendarDetailView()
                .padding(.top, 10)
        }
    }
}

// MARK: - Preview
struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(CalendarViewModel())
    }
}


