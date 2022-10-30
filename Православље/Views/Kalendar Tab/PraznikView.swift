//
//  PraznikView.swift
//  Pravoslavlje
//
//  Created by VELJKO on 30.7.22..
//

import SwiftUI
import CoreData

struct PraznikView: View {
    
    @Environment(\.dismiss) private var dismissView
    @EnvironmentObject private var viewModel : CalendarViewModel
    
    @State private var pageSelected : Int = 0
    
    var body: some View {
        ZStack {
            backgroundGradiant()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {
                    header
                    pictureSection
                    aboutDescription
                }
                
            }
            .frame(maxWidth: .infinity)

        }
        .onDisappear {
            viewModel.currentPraznik = 0
            viewModel.prazniciInDay.removeAll()
        }
    }//


}//

extension PraznikView {
    
    // MARK: - Header with Button and Date
    private var header : some View {
        HStack {
            ArrowDownButton()
                .padding(.bottom, 5)
            Spacer()
            // Header title - day + month
            if let title = "\(viewModel.currentDay). \(viewModel.getMonthName())" {
                Text(title)
                    .font(Font.custom(K.Fonts.clara, size: 25))
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
            }
            Spacer()
            ArrowDownButton()
                .opacity(0)
        }
    }
    
    // MARK: - Picture and Name Section
    private var pictureSection : some View {
        ZStack(alignment:.top) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .shadow(radius: 4)
            
            TabView(selection: $pageSelected) {
                ForEach(viewModel.prazniciInDay, id: \.self) { praznik in
                    
                    let praznikNumber = Int(praznik.number)
                    
                    VStack(spacing: 40) {
                        // Praznik image
                        if let image = viewModel.getPraznik(current: praznikNumber).picture {
                            Image(image)
                                .resizable()
                                .aspectRatio(0.8, contentMode: .fit)
                                .frame(maxHeight: 200)
                                .cornerRadius(10)
                        }
                        
                        
                        // Praznik name
                        if let name = viewModel.getPraznik(current: praznikNumber).name {
                            Text(name)
                                .multilineTextAlignment(.center)
                                .font(Font.custom(K.Fonts.clara, size: 22))
                        }
                    }
                    .tag(viewModel.getTag(number: praznikNumber))
                    .onChange(of: pageSelected) { newValue in
                        withAnimation {
                            viewModel.currentPraznik = newValue
                        }
                    }
                    .padding()
                }
            }
            .frame(height: 400)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
        .padding(.horizontal)
    }
    
    // MARK: - About Praznik Description
    private var aboutDescription : some View {
        // Praznik about description
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .shadow(radius: 4)
            
            if let about = viewModel.getPraznikAbout() {
                Text(about)
                    .font(Font.custom(K.Fonts.clara, size: 22))
                    .padding()
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - Preview
struct PraznikView_Previews: PreviewProvider {
    static var previews: some View {
        PraznikView()
            .environmentObject(CalendarViewModel())
    }
}
