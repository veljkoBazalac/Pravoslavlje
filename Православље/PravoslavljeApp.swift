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
//            CalendarView()
                .environmentObject(manastirViewModel)
                .environmentObject(calendarViewModel)
                .onAppear {
                    manastirViewModel.fetchData()
                    manastirViewModel.checkIfLocationServicesIsEnabled()
                    calendarViewModel.fetchData()
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

