//
//  WebView.swift
//  Православље
//
//  Created by VELJKO on 9.10.22..
//

import Foundation
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    
    let url : URL?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let safeURL = url else { return }
        
        let request = URLRequest(url: safeURL)
        uiView.load(request)
    }
}
