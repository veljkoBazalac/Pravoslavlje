//
//  ManastiriViewModel.swift
//  Православље
//
//  Created by VELJKO on 23.9.22..
//

import SwiftUI
import MapKit
import CoreData

final class ManastiriViewModel : ObservableObject {
    
    let manager : CoreDataManager
    
    // All Eparhije Data
    @Published var eparhijeArray : [EparhijaEntity] = []
    // All loaded Locations
    @Published var manastiriArray : [ManastirEntity] = []
    
    // Current location on map
    @Published var selectedManastir : ManastirEntity?
    
//    {
//        didSet {
//            updateMapRegion(location: selectedManastir) // Svaki put kada se promeni mapLocation, zvace funkciju
//        }
//    }
    
    // Current list of locations
    @Published var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // Show list of locations
    @Published var showLocationsList : Bool = false
    
    // MARK: - INIT
    init(manager: CoreDataManager = .shared) {
        self.manager = manager
        fetchData()
    }
    
    // MARK: - Fetch Manastir data from CoreData database
    func fetchData() {
        
        manastiriArray = CoreDataManager.shared.getManastirData()
        eparhijeArray = CoreDataManager.shared.getEparhijaData()
        
        if let location = manastiriArray.first {
            selectedManastir = location
            updateMapRegion(location: location)
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
            selectedManastir = location
            showLocationsList = false
        }
    }
//
//    // MARK: -  Go to Next Manastir in manastiriArray
//    func nextButtonPressed() {
//        // Get the currentIndex
//        guard let currentIndex = manastiriArray.firstIndex(where: { $0 == selectedManastir }) else {
//            print("Could not find current index in locations array!")
//            return
//        }
//
//        // Check if nextIndex not currentIndex
//        let nextIndex = currentIndex + 1
//        guard manastiriArray.indices.contains(nextIndex) else { // Proveriti da li postoji item sa tim indexom
//            // Next index is NOT valid
//            // Restart from 0
//            guard let firstLocation = manastiriArray.first else { return }
//            showNextLocation(location: firstLocation)
//            return
//        }
//
//        // Next index IS Valid
//        let nextLocation = manastiriArray[nextIndex] // Uvek prvo proveriti da li postoji item sa tim indexom
//        showNextLocation(location: nextLocation)
//    }

}


