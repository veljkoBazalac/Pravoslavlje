//
//  ManastirAnnotationView.swift
//  Православље
//
//  Created by VELJKO on 24.9.22..
//

import SwiftUI

// MARK: - Annotation View for Map
struct ManastirAnnotationView: View {
    
    @State var color : Color
    
    var body: some View {
        VStack(spacing: 0) {
            Image(K.Images.Annotations.monastery)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(color)
                .clipShape(Circle())
                
            Image(systemName: K.Images.Annotations.triangle)
                .resizable()
                .scaledToFit()
                .foregroundColor(color)
                .frame(width: 7, height: 7)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
        }
        .offset(y: -14)
    }
}

// MARK: - Preview
struct ManastirAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            ManastirAnnotationView(color: Color.orange)
        }
    }
}
