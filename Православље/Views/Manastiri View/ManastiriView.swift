//
//  ManastiriMapView.swift
//  Православље
//
//  Created by VELJKO on 23.9.22..
//

import SwiftUI
import MapKit
import CoreData

struct ManastiriView: View {
    
    @EnvironmentObject private var viewModel : ManastiriViewModel
    @State private var showEparhijeMap : Bool = false
    
    var body: some View {
        if viewModel.locationIsDisabled == false {
            ZStack {
                mapLayer
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    header
                        .padding()
                    Spacer()
                    locationsPreviewStack
                }
                EparhijeMapView(showView: $showEparhijeMap)
            }
            .fullScreenCover(isPresented: $viewModel.showCalendar) {
                CalendarView()
            }
        } else {
            blackBackgroundForPopUp
        }
    }
}

extension ManastiriView {
    
    // MARK: - Header with Find options
    private var header : some View {
        VStack {
            HStack(spacing: 10) {
                // Eparhije Map Button
                Button {
                    withAnimation(.linear(duration: 0.2)) {
                        self.showEparhijeMap.toggle()
                    }
                } label: {
                    Image(systemName: K.Images.map)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.primary)
                        .padding()
                }
                // Manastiri List
                Button(action: viewModel.toggleManastiriList) {
                    VStack(spacing: 0) {
                        Text(K.Text.findMonastery)
                            .font(Font.custom(K.Fonts.clara, size: 22))
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                    }
                }
                // Calendar Button
                Button(action: viewModel.toggleCalendar) {
                    Image(systemName: K.Images.calendar)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.primary)
                        .padding()
                }
            }
            // Show Manastiri List View
            if viewModel.showLocationsList {
                ManastiriListView()
            }
        } 
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3),
                radius: 20,
                x: 0,
                y: 15)
    }
    
    // MARK: - Map
    private var mapLayer : some View {
        Map(coordinateRegion: $viewModel.mapRegion,
            showsUserLocation: true,
            annotationItems: viewModel.manastiriArray,
            annotationContent: { manastir in
            MapAnnotation(coordinate: viewModel.getCoordinates(location: manastir)) {
                if let eparhijaName = manastir.eparhija?.name {
                    // Add Annotation with Eparhija Color
                    ManastirAnnotationView(color: viewModel.getEparhijaColor(eparhijaName: eparhijaName))
                        .scaleEffect(viewModel.selectedManastir == manastir ? 1.1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            viewModel.showNextLocation(location: manastir)
                        }
                }
            }
        })
    }

    // MARK: - Location Preview
    private var locationsPreviewStack : some View {
        ZStack {
            ForEach(viewModel.manastiriArray) { manastir in
                if viewModel.selectedManastir == manastir {
                    ManastirPreviewView(manastir: manastir)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
        .frame(height: 250)
    }
    
    // MARK: - Black background with PopUp if Location is disabled
    private var blackBackgroundForPopUp : some View {
        Color.black
            .ignoresSafeArea()
            .modifier(ShowEnableLocationAlert(showAlert: viewModel.locationIsDisabled ?? false))
            .onAppear {
                viewModel.checkIfLocationServicesIsEnabled()
            }
    }
}

// MARK: - Preview
struct ManastiriMapView_Previews: PreviewProvider {
    static var previews: some View {
        ManastiriView()
            .environmentObject(ManastiriViewModel())
    }
}



