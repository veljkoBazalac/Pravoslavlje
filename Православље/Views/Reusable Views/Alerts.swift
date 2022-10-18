//
//  Alerts.swift
//  Православље
//
//  Created by VELJKO on 5.10.22..
//

import Foundation
import SwiftUI
//
//struct ShowEnableLocationAlert: ViewModifier {
//
//    @State var showAlert : Bool
//
//    init(showAlert: Bool) {
//        self.showAlert = showAlert
//    }
//
//    func body(content: Content) -> some View {
//        content
//            .alert(isPresented: $showAlert) {
//                Alert(title: Text("Локација блокирана."),
//                      message: Text("Потребна је Ваша локација да би апликација успешно функционисала."),
//                      dismissButton: .default(Text("Иди у опције").foregroundColor(Color.blue), action: {
//                    // Go to Settings
//                    if let bundleId = Bundle.main.bundleIdentifier,
//                       let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)") {
//                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                    }
//                }))
//            }
//    }
//}
