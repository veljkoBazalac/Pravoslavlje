//
//  Buttons.swift
//  Православље
//
//  Created by VELJKO on 20.10.22..
//

import SwiftUI

struct ArrowDownButton : View {
    
    @Environment(\.dismiss) private var dismissView
    
    var body: some View {
        Button {
            dismissView()
        } label: {
            HStack() {
                Image(systemName: K.Images.chevronLeft)
                    .rotationEffect(Angle(degrees: -90))
                    .font(.headline)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 10)
                    .foregroundColor(.primary)
                    .background(.thickMaterial)
                    .cornerRadius(5)
                    .shadow(radius: 4)
                    .padding()
            }
        }
        .padding(.top, 5)
    }
}
