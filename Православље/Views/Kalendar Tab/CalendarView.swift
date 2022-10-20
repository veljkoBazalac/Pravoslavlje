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
            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .center) {
                    backButton
                    Spacer()
                    infoButton
                }
                calendarDetailView
                Spacer(minLength: 0)
            }
            FastingView(showView: $showView)
        }
        .background(.ultraThinMaterial)
    }
}

extension CalendarView {
    
    // MARK: - Back Button
    private var backButton : some View {
        Button {
            dismissView()
        } label: {
            HStack() {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .rotationEffect(Angle(degrees: -90))
                    .padding(.leading, 20)
            }
        }
        .padding(.top, 5)
    }
    
    // MARK: - Info Button
    private var infoButton : some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                self.showView.toggle()
            }
        } label: {
            Image(systemName: "info.circle")
                .font(.title2)
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

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(CalendarViewModel())
    }
}


