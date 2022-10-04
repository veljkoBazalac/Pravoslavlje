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
    
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
            VStack(spacing: 0) {
                header
                    .padding()
                Spacer()
                locationsPreviewStack
            }
        }
    }
}

extension ManastiriView {
    
    private var header : some View {
        VStack {
            Button(action: viewModel.toggleManastiriList) {
                HStack {
                    Image(systemName: "arrow.down")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding()
                        .rotationEffect(Angle(degrees: viewModel.showLocationsList ? -180 : 0))
                    
                    VStack(spacing: 0) {
                        Text("Пронађи Манастир")
                            .font(Font.custom("CormorantSC-Bold", size: 20))
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                    }
                    
                    Image(systemName: "xmark")
                        .font(.headline)
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
    
    private var mapLayer : some View {
        Map(coordinateRegion: $viewModel.mapRegion,
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

    private var locationsPreviewStack : some View {
        ZStack {
            ForEach(viewModel.manastiriArray) { manastir in
                if viewModel.selectedManastir == manastir {
                    ManastirPreviewView(manastir: manastir)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        //.frame(maxWidth: maxWithForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
        .frame(height: 250)
    }
    
}

struct ManastiriMapView_Previews: PreviewProvider {
    static var previews: some View {
        ManastiriView()
            .environmentObject(ManastiriViewModel())
    }
}



