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
    let dateHolder = DateHolder()
    
    var body: some Scene {
        WindowGroup {
            ManastiriView()
                .environmentObject(dateHolder)
                .environmentObject(viewModel)
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

// MARK: - Clean URL for Cyrillic letters
extension String {
    
 func getCleanedURL() -> URL? {
    guard self.isEmpty == false else {
        return nil
    }
    if let url = URL(string: self) {
        return url
    } else {
        if
            let urlEscapedString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let escapedURL = URL(string: urlEscapedString){
            return escapedURL
        }
    }
    return nil
 }
}
