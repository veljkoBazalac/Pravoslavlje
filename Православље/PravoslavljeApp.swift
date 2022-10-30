//
//  PravoslavljeApp.swift
//  Pravoslavlje
//
//  Created by VELJKO on 21.7.22..
//

import SwiftUI

@main
struct PravoslavljeApp: App {
    @StateObject private var manastirViewModel = ManastiriViewModel()
    @StateObject private var calendarViewModel = CalendarViewModel()
    
    var body: some Scene {
        WindowGroup {
            ManastiriView()
                .environmentObject(manastirViewModel)
                .environmentObject(calendarViewModel)
                .onAppear {
                    manastirViewModel.checkIfLocationServicesIsEnabled()
                    manastirViewModel.fetchData()
                    calendarViewModel.fetchData()
                }
        }
    }
    
}

