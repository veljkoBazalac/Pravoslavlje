//
//  PravoslavljeApp.swift
//  Pravoslavlje
//
//  Created by VELJKO on 21.7.22..
//

import SwiftUI

@main
struct PravoslavljeApp: App {

    @StateObject private var viewModel = ManastiriViewModel()
    
    var body: some Scene {
        
        WindowGroup {
            let dateHolder = DateHolder()
            
            ManastiriMapView()
//                .environmentObject(dateHolder)
                .environmentObject(viewModel)
        }
    }
    
}
