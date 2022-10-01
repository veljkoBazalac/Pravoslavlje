//
//  DataController.swift
//  Pravoslavlje
//
//  Created by VELJKO on 23.7.22..
//

import CoreData
import Foundation

class CoreDataManager: ObservableObject {
    
    static let instance = CoreDataManager()
    var container : NSPersistentContainer
    var context : NSManagedObjectContext
    
    init() {
        print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
        container = NSPersistentContainer(name: "PravoslavljeContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
        }
        context = container.viewContext
        
        preloadDatabase()
    }
    
    func preloadDatabase() {
        guard let firstStoreURL = container.persistentStoreCoordinator.persistentStores.first?.url else {
            print("Missing first store URL - could not destroy")
            return
        }
        
        do {
            try container.persistentStoreCoordinator.destroyPersistentStore(at: firstStoreURL, ofType: "sqlite", options: nil)
        } catch  {
            print("Unable to destroy persistent store: \(error) - \(error.localizedDescription)")
        }
        
        let sqlitePath = Bundle.main.path(forResource: "PravoslavljeContainer", ofType: "sqlite")
        let sqlitePath_shm = Bundle.main.path(forResource: "PravoslavljeContainer", ofType: "sqlite-shm")
        let sqlitePath_wal = Bundle.main.path(forResource: "PravoslavljeContainer", ofType: "sqlite-wal")
        
        let newURL1 = URL(fileURLWithPath: sqlitePath!)
        let newURL2 = URL(fileURLWithPath: sqlitePath_shm!)
        let newURL3 = URL(fileURLWithPath: sqlitePath_wal!)
        
        let oldURL1 = URL(fileURLWithPath: NSPersistentContainer.defaultDirectoryURL().relativePath + "/PravoslavljeContainer.sqlite")
        let oldURL2 = URL(fileURLWithPath: NSPersistentContainer.defaultDirectoryURL().relativePath + "/PravoslavljeContainer.sqlite-shm")
        let oldURL3 = URL(fileURLWithPath: NSPersistentContainer.defaultDirectoryURL().relativePath + "/PravoslavljeContainer.sqlite-wal")
        
        do {
            try FileManager.default.removeItem(at: oldURL1)
            try FileManager.default.removeItem(at: oldURL2)
            try FileManager.default.removeItem(at: oldURL3)
            
            try FileManager.default.copyItem(at: newURL1, to: oldURL1)
            try FileManager.default.copyItem(at: newURL2, to: oldURL2)
            try FileManager.default.copyItem(at: newURL3, to: oldURL3)
        } catch {
            print("Error preloading database: \(error)")
        }
        
        container = NSPersistentContainer(name: "PravoslavljeContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
        }
        context = container.viewContext
    }
    
//
//    // MARK: - Preload Manastir Database
//    private func preloadManastirData() {
//
//        let PRELOADED_DATA_KEY = "didPreloadManastirData"
//
//        let userDefaults = UserDefaults.standard
//
//        if userDefaults.bool(forKey: PRELOADED_DATA_KEY) == false {
//
//        }
//
//    }
    
}
