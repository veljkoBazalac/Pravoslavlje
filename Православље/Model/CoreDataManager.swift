//
//  DataController.swift
//  Pravoslavlje
//
//  Created by VELJKO on 23.7.22..
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    var container : NSPersistentContainer
    var context : NSManagedObjectContext
    
    init(inMemory: Bool = false) {
        print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
        container = NSPersistentContainer(name: "PravoslavljeContainer")
        
        if inMemory == true {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
        }
        context = container.viewContext
        
        preloadDatabase()
    }
}

// MARK: - Fetch Data Functions
extension CoreDataManager {
    
    // MARK: - Get Manastir Data
    func getManastirData() -> [ManastirEntity] {
        let request = NSFetchRequest<ManastirEntity>(entityName: "ManastirEntity")
        
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    // MARK: - Get Eparhije Data
    func getEparhijaData() -> [EparhijaEntity] {
        let request = NSFetchRequest<EparhijaEntity>(entityName: "EparhijaEntity")
        
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    // MARK: - Get Month Data
    func getMonthData() -> [MonthEntity] {
        let request = NSFetchRequest<MonthEntity>(entityName: "MonthEntity")
        
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    // MARK: - Get Praznik Data
    func getPraznikData() -> [PraznikEntity] {
        let request = NSFetchRequest<PraznikEntity>(entityName: "PraznikEntity")
        
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
}

// MARK: - Preload CoreData database
extension CoreDataManager {
    
    func preloadDatabase() {
        
        let PRELOADED_COREDATA_KEY = "PRELOADED_COREDATA"
        let userDefaults = UserDefaults.standard
        
        if userDefaults.bool(forKey: PRELOADED_COREDATA_KEY) == false {
            
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
                
                userDefaults.set(true, forKey: PRELOADED_COREDATA_KEY)
                
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
    }
}


