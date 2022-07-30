//
//  ContentView.swift
//  Pravoslavlje
//
//  Created by VELJKO on 21.7.22..
//

import SwiftUI
import CoreData

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView: View {
    init() {
        preloadManastirData()
    
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "CormorantSC-Medium", size: 30)!]
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(name: "CormorantSC-Bold", size: 14)!], for: [])
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Почетна")
                }
            
            ManastirListView()
                .tabItem {
                    Image(systemName: "cross")
                    Text("Манастири")
                }
            
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Календар")
                }
        }
    }
    
    // MARK: - Preload Manastir Database
    private func preloadManastirData() {
        
        let PRELOADED_DATA_KEY = "didPreloadManastirData"

        let userDefaults = UserDefaults.standard

        if userDefaults.bool(forKey: PRELOADED_DATA_KEY) == false {
            
            let sqlitePath = Bundle.main.path(forResource: "Pravoslavlje", ofType: "sqlite")
            let sqlitePath_shm = Bundle.main.path(forResource: "Pravoslavlje", ofType: "sqlite-shm")
            let sqlitePath_wal = Bundle.main.path(forResource: "Pravoslavlje", ofType: "sqlite-wal")
            
            let newURL1 = URL(fileURLWithPath: sqlitePath!)
            let newURL2 = URL(fileURLWithPath: sqlitePath_shm!)
            let newURL3 = URL(fileURLWithPath: sqlitePath_wal!)
            
            let oldURL1 = URL(fileURLWithPath: NSPersistentContainer.defaultDirectoryURL().relativePath + "/Pravoslavlje.sqlite")
            let oldURL2 = URL(fileURLWithPath: NSPersistentContainer.defaultDirectoryURL().relativePath + "/Pravoslavlje.sqlite-shm")
            let oldURL3 = URL(fileURLWithPath: NSPersistentContainer.defaultDirectoryURL().relativePath + "/Pravoslavlje.sqlite-wal")
            
            do {
                try FileManager.default.removeItem(at: oldURL1)
                try FileManager.default.removeItem(at: oldURL2)
                try FileManager.default.removeItem(at: oldURL3)
                
                try FileManager.default.copyItem(at: newURL1, to: oldURL1)
                try FileManager.default.copyItem(at: newURL2, to: oldURL2)
                try FileManager.default.copyItem(at: newURL3, to: oldURL3)
                
                userDefaults.set(true, forKey: PRELOADED_DATA_KEY)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

extension View {
    func printUI(_ args: Any..., separator: String = " ", terminator: String = "\n") -> EmptyView {
        let output = args.map(String.init(describing:)).joined(separator: separator)
        print(output, terminator: terminator)
        return EmptyView()
    }
}
