//
//  Alerts.swift
//  Православље
//
//  Created by VELJKO on 5.10.22..
//

import Foundation
import SwiftUI

// MARK: - Alert user if location is disabled
struct ShowEnableLocationAlert: ViewModifier {

    @State var showAlert : Bool

    init(showAlert: Bool) {
        self.showAlert = showAlert
    }

    func body(content: Content) -> some View {
        content
            .alert(isPresented: $showAlert) {
                Alert(title: Text(K.Text.Alerts.locationBlocked),
                      message: Text(K.Text.Alerts.weNeedYourLocation),
                      dismissButton: .default(Text(K.Text.Alerts.goToSettings).foregroundColor(Color.blue), action: {
                    // Go to Settings
                    if let bundleId = Bundle.main.bundleIdentifier,
                       let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)") {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }))
            }
    }
}
