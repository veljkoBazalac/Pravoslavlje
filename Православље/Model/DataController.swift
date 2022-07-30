//
//  DataController.swift
//  Pravoslavlje
//
//  Created by VELJKO on 23.7.22..
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Pravoslavlje")
    
    init() {
        container.loadPersistentStores { description, err in
            if let error = err {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
