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
        print("App Support Directory: ", FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last ?? "Not Found!")
        container = NSPersistentContainer(name: K.CoreData.pravoslavlje)
        
        if inMemory == true {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: K.CoreData.URLs.url4)
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
        let request = NSFetchRequest<ManastirEntity>(entityName: K.CoreData.Entities.manastir)
        
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    // MARK: - Get Eparhije Data
    func getEparhijaData() -> [EparhijaEntity] {
        let request = NSFetchRequest<EparhijaEntity>(entityName: K.CoreData.Entities.eparhija)
        
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    // MARK: - Get Month Data
    func getMonthData() -> [MonthEntity] {
        let request = NSFetchRequest<MonthEntity>(entityName: K.CoreData.Entities.month)
        
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    // MARK: - Get Praznik Data
    func getPraznikData() -> [PraznikEntity] {
        let request = NSFetchRequest<PraznikEntity>(entityName: K.CoreData.Entities.praznik)
        
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
        
        let PRELOADED_COREDATA_KEY = K.AppStorage.preloadedCoreData
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
            
            let sqlitePath = Bundle.main.path(forResource: K.CoreData.pravoslavlje, ofType: K.CoreData.Extensions.sqlite1)
            let sqlitePath_shm = Bundle.main.path(forResource: K.CoreData.pravoslavlje, ofType: K.CoreData.Extensions.sqlite2)
            let sqlitePath_wal = Bundle.main.path(forResource: K.CoreData.pravoslavlje, ofType: K.CoreData.Extensions.sqlite3)
            
            let newURL1 = URL(fileURLWithPath: sqlitePath!)
            let newURL2 = URL(fileURLWithPath: sqlitePath_shm!)
            let newURL3 = URL(fileURLWithPath: sqlitePath_wal!)
            
            let oldURL1 = URL(fileURLWithPath: NSPersistentContainer.defaultDirectoryURL().relativePath + K.CoreData.URLs.url1)
            let oldURL2 = URL(fileURLWithPath: NSPersistentContainer.defaultDirectoryURL().relativePath + K.CoreData.URLs.url2)
            let oldURL3 = URL(fileURLWithPath: NSPersistentContainer.defaultDirectoryURL().relativePath + K.CoreData.URLs.url3)
            
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
            
            container = NSPersistentContainer(name: K.CoreData.pravoslavlje)
            container.loadPersistentStores { description, error in
                if let error = error {
                    print("ERROR LOADING CORE DATA. \(error)")
                }
            }
            context = container.viewContext
        }
    }
}


