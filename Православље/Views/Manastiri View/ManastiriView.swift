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
                
                if viewModel.showEparhijeMap {
                    EparhijeMapView()
                }
            }
            .onAppear {
                viewModel.fetchData()
                viewModel.checkIfLocationServicesIsEnabled()
            }
            .fullScreenCover(isPresented: $viewModel.showCalendar) {
                viewModel.toggleCalendar()
            } content: {
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
                
                Button(action: viewModel.toggleEparhijeMap) {
                    Image(systemName: "map.fill")
                        .frame(width: 25, height: 25)
                        .foregroundColor(.primary)
                        .padding()
                }
                
                Button(action: viewModel.toggleManastiriList) {
                    VStack(spacing: 0) {
                        Text("Пронађи Манастир")
                            .font(Font.custom("CormorantSC-Bold", size: 20))
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                Button(action: viewModel.toggleCalendar) {
                    Image(systemName: "calendar")
                        .frame(width: 25, height: 25)
                        .foregroundColor(.primary)
                        .padding()
                }
            }
            
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
        Map(coordinateRegion: $viewModel.mapRegion, showsUserLocation: true,
            annotationItems: viewModel.manastiriArray,
            annotationContent: { location in
            MapAnnotation(coordinate: viewModel.getCoordinates(location: location)) {
                ManastirAnnotationView()
                    .scaleEffect(viewModel.selectedManastir == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        viewModel.showNextLocation(location: location)
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
//            .modifier(ShowEnableLocationAlert(showAlert: viewModel.locationIsDisabled ?? false))
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



