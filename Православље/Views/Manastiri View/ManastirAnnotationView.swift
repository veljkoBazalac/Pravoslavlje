//
//  ManastirAnnotationView.swift
//  Православље
//
//  Created by VELJKO on 24.9.22..
//

import SwiftUI

struct ManastirAnnotationView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            Image("monastery")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(Color.orange)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.orange)
                .frame(width: 7, height: 7)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
        }
        .offset(y: -14)
    }
}

struct ManastirAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            ManastirAnnotationView()
        }
    }
}
