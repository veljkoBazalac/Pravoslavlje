//
//  EparhijeMapView.swift
//  Православље
//
//  Created by VELJKO on 11.10.22..
//

import SwiftUI

// MARK: - Image with Eparhije Map
struct EparhijeMapView: View {
    
    @Binding var showView : Bool
    
    var body: some View {
        ZStack {
            if showView {
                Color.black.opacity(showView ? 0.4 : 0).ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.2)) {
                            self.showView.toggle()
                        }
                    }
                
                Image(K.Images.eparhije)
                    .resizable()
                    .frame(width: getRect().width - 30, height: 350)
                    .scaledToFit()
                    .addPinchZoom()
            }
        }
    }
}

// MARK: - Preview
struct EparhijeMapView_Previews: PreviewProvider {
    static var previews: some View {
        EparhijeMapView(showView: .constant(true))
    }
}
