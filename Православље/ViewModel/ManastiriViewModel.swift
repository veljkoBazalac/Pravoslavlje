//
//  ManastiriViewModel.swift
//  Православље
//
//  Created by VELJKO on 23.9.22..
//

import SwiftUI
import MapKit
import CoreData

final class ManastiriViewModel : NSObject, ObservableObject {
    
    let manager : CoreDataManager
    var locationManager : CLLocationManager?
    @AppStorage("USER_LOCATION_DISABLED") var locationIsDisabled: Bool?
    @AppStorage("NAVIGATION_APP") var navigationApp : String?
    
    // All Eparhije Data
    @Published var eparhijeArray : [EparhijaEntity] = []
    // All loaded Locations
    @Published var manastiriArray : [ManastirEntity] = []
    
    // Current location on map
    @Published var selectedManastir : ManastirEntity?
    
    // Current list of locations
    @Published var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
    
    // Show list of locations
    @Published var showLocationsList : Bool = false
    // Show Eparhije map
    @Published var showEparhijeMap : Bool = false
    // Show Calendar
    @Published var showCalendar : Bool = false
    
    // MARK: - INIT
    init(manager: CoreDataManager = .shared) {
        self.manager = manager
    }
    
    // MARK: - Fetch Manastir data from CoreData database
    func fetchData() {
        manastiriArray = CoreDataManager.shared.getManastirData()
        eparhijeArray = CoreDataManager.shared.getEparhijaData()
    }
    
}

// MARK: - Location Functions
extension ManastiriViewModel {
    
    // MARK: - Get Coordinates for Manastir
    func getCoordinates(location: ManastirEntity) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }

    // MARK: - Update Map Region showed on View
    private func updateMapRegion(location: ManastirEntity) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: getCoordinates(location: location),
                span: mapSpan)
        }
    }

    // MARK: - Show Next Monastiry
    func showNextLocation(location: ManastirEntity) {
        withAnimation(.easeInOut) {
            selectedManastir = location
            showLocationsList = false
            updateMapRegion(location: location)
        }
    }
    
    // MARK: - Get Eparhija Color
    func getEparhijaColor(eparhijaName: String? = "") -> Color {
        switch eparhijaName {
        case "жичка":
            return Color.red
        case "ваљевска":
            return Color.green
        case "браничевска":
            return Color.blue
        case "рашко-призренска":
            return Color.purple
        default:
            return Color.orange
        }
    }
}

// MARK: - Toggle Views
extension ManastiriViewModel {
    
    // MARK: - Show / Hide Eparhije Map
    func toggleEparhijeMap() {
        withAnimation(.easeInOut) {
            showEparhijeMap.toggle()
        }
    }

    // MARK: - Show / Hide Locations List
    func toggleManastiriList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    // MARK: - Show / Hide Calendar View
    func toggleCalendar() {
        withAnimation(.easeInOut) {
            showCalendar.toggle()
        }
    }
}

// MARK: - Start Navigation
extension ManastiriViewModel {
    
    // MARK: - Open Google Maps App
    func openGoogleMaps() {
        guard let manastir = selectedManastir else {return}
        
        let urlString = "comgooglemaps://?saddr=&daddr=\(manastir.latitude),\(manastir.longitude)&directionsmode=driving"
        
        if UIApplication.shared.canOpenURL(URL(string: urlString)!) {
            UIApplication.shared.open(URL(string: urlString)!)
            navigationApp = "Google"
        }
    }
    
    // MARK: - Open Apple Maps App
    func openAppleMaps() {
        guard let manastir = selectedManastir else {return}
        
        let urlString = "maps://?saddr=&daddr=\(manastir.latitude),\(manastir.longitude)"
        
        if UIApplication.shared.canOpenURL(URL(string: urlString)!) {
            UIApplication.shared.open(URL(string: urlString)!)
            navigationApp = "Apple"
        }
    }
}

// MARK: - User Location
extension ManastiriViewModel: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager = CLLocationManager()
            self.locationManager?.delegate = self
        } else {
            print("Ваша Локација је искључена. Молимо Вас да укључите локацију у опцијама.")
        }
    }
    
    private func checkLocationAuth() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            locationIsDisabled = true
        case .authorizedAlways, .authorizedWhenInUse:
            locationIsDisabled = false
            if let coordinates = locationManager.location?.coordinate {
                mapRegion = MKCoordinateRegion(center: coordinates,
                                               span: MKCoordinateSpan(latitudeDelta: 1.0,
                                                                      longitudeDelta: 1.0))
            }
        @unknown default:
            break
        }
    }
}


