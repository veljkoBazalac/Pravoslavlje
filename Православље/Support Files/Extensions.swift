//
//  Extensions.swift
//  Православље
//
//  Created by VELJKO on 30.10.22..
//

import Foundation
import SwiftUI

// MARK: - View Extensions
extension View {
    // MARK: - Print UI for easy print debug
    func printUI(_ args: Any..., separator: String = " ", terminator: String = "\n") -> EmptyView {
        let output = args.map(String.init(describing:)).joined(separator: separator)
        print(output, terminator: terminator)
        return EmptyView()
    }
    
    // MARK: - Background Gradiant Color
    func backgroundGradiant() -> some View {
        LinearGradient(
            gradient: Gradient(colors: [Color(K.Colors.backgroundColor), Color(K.Colors.backgroundColor).opacity(0.3)]),
            startPoint: .top,
            endPoint: .bottom)
        .ignoresSafeArea()
    }
    
    // MARK: - Get Screen Bounds
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    // MARK: - Allow Pinch Zoom for Image
    func addPinchZoom() -> some View {
        return PinchZoomContext {
            self
        }
    }
    
}


