//
//  ManastiriMapView.swift
//  Православље
//
//  Created by VELJKO on 23.9.22..
//

import SwiftUI
import MapKit
import CoreData

struct ManastiriMapView: View {
    
    @EnvironmentObject private var vm : ManastiriViewModel
    
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
            VStack(spacing: 0) {
                header
                    .padding()
                    //.frame(maxWidth: maxWithForIpad)
                Spacer()
                locationsPreviewStack
            }
        }
    }
}

extension ManastiriMapView {
    
    private var header : some View {
        VStack {
            Button(action: vm.toggleManastiriList) {
                //vm.mapLocation.name + ", " + vm.mapLocation.eparhijaName
                Text("TEST")
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    //.animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                    }
            }
            
            if vm.showLocationsList {
                //ManastiriListView()
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
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.manastiriArray,
            annotationContent: { location in
            MapAnnotation(coordinate: vm.getCoordinates(location: location)) {
                    ManastirAnnotationView()
                        .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            vm.showNextLocation(location: location)
                        }
                }
            })
    }

    private var locationsPreviewStack : some View {
        ZStack {
            ForEach(vm.manastiriArray) { manastir in
                if vm.mapLocation == manastir {
                    ManastirPreviewView(manastir: manastir, eparhija: manastir.eparhija?.name)
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
    }
    
}

struct ManastiriMapView_Previews: PreviewProvider {
    
//    static let manastirEntity = NSManagedObjectModel.mergedModel(from: nil)?.entitiesByName["ManastirEntity"]
    
    static var previews: some View {
        ManastiriMapView()
            .environmentObject(ManastiriViewModel())
    }
//
//    static var previewView : some View {
//        let manastir = ManastirEntity(entity: manastirEntity!, insertInto: nil)
//        manastir.name = "Жича"
//        manastir.picture = "zica"
//
//        return ManastirPreviewView(manastir: manastir, eparhija: "жичка")
//    }
}
