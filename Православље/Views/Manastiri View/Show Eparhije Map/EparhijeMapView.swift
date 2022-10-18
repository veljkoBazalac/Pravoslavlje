//
//  EparhijeMapView.swift
//  Православље
//
//  Created by VELJKO on 11.10.22..
//

import SwiftUI

struct EparhijeMapView: View {
    
    @EnvironmentObject private var viewModel : ManastiriViewModel
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
                .onTapGesture {
                    viewModel.toggleEparhijeMap()
                }
            
            Image("eparhije")
                .resizable()
                .frame(width: getRect().width - 30, height: 350)
                .scaledToFit()
                .addPinchZoom()
        }
    }
}

struct EparhijeMapView_Previews: PreviewProvider {
    static var previews: some View {
        EparhijeMapView()
    }
}
