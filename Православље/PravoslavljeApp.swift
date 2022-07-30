//
//  PravoslavljeApp.swift
//  Pravoslavlje
//
//  Created by VELJKO on 21.7.22..
//

import SwiftUI

@main
struct PravoslavljeApp: App {

    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        
        WindowGroup {
            let dateHolder = DateHolder()
            
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dateHolder)
        }
    }
    
}
