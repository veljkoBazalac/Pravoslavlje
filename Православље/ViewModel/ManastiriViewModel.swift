//
//  ManastiriViewModel.swift
//  Православље
//
//  Created by VELJKO on 23.9.22..
//

import Foundation
import SwiftUI
import MapKit
import CoreData


class ManastiriViewModel : ObservableObject {
    
    let manager = CoreDataManager.instance
    
    // All Eparhije Data
    @Published var eparhijeArray : [EparhijaEntity] = []
    // All loaded Locations
    @Published var manastiriArray : [ManastirEntity] = []
    
    // Current location on map
    @Published var mapLocation : ManastirEntity?
    
//    {
//        didSet {
//            updateMapRegion(location: mapLocation) // Svaki put kada se promeni mapLocation, zvace funkciju
//        }
//    }
    
    // Current list of locations
    @Published var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // Show list of locations
    @Published var showLocationsList : Bool = false
    
    // Show location detail via sheet
    @Published var sheetLocation : ManastirEntity? = nil
    
    // MARK: - INIT
    init() {
        fetchManastiri()
    }
    
    // MARK: - Fetch Manastir data from CoreData database
    func fetchManastiri() {
        let request = NSFetchRequest<ManastirEntity>(entityName: "ManastirEntity")
        let request2 = NSFetchRequest<EparhijaEntity>(entityName: "EparhijaEntity")
        
        do {
            manastiriArray = try manager.context.fetch(request)
            eparhijeArray = try manager.context.fetch(request2)
            if let location = manastiriArray.first {
                mapLocation = location
                updateMapRegion(location: location)
            }
            print(manastiriArray)
        } catch let error {
            print("Error fetching: \(error)")
        }
    }
    
    // MARK: - Get Coordinates for Manastir
    func getCoordinates(location: ManastirEntity) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }

    // MARK: - Update Map Region showed on View
    private func updateMapRegion(location: ManastirEntity) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: getCoordinates(location: location), // Centar mape
                span: mapSpan) // Koliko ce biti zumirano
        }
    }

    // MARK: - Show / Hide Locations List
    func toggleManastiriList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }

    // MARK: - Show Next Monastiry
    func showNextLocation(location: ManastirEntity) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }

    // MARK: -  Go to Next Manastir in manastiriArray
    func nextButtonPressed() {
        // Get the currentIndex
        guard let currentIndex = manastiriArray.firstIndex(where: { $0 == mapLocation }) else {
            print("Could not find current index in locations array!")
            return
        }

        // Check if nextIndex not currentIndex
        let nextIndex = currentIndex + 1
        guard manastiriArray.indices.contains(nextIndex) else { // Proveriti da li postoji item sa tim indexom
            // Next index is NOT valid
            // Restart from 0
            guard let firstLocation = manastiriArray.first else { return }
            showNextLocation(location: firstLocation)
            return
        }

        // Next index IS Valid
        let nextLocation = manastiriArray[nextIndex] // Uvek prvo proveriti da li postoji item sa tim indexom
        showNextLocation(location: nextLocation)
    }

}
