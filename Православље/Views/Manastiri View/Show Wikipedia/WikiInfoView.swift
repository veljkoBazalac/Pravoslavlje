//
//  WikiInfoView.swift
//  Православље
//
//  Created by VELJKO on 9.10.22..
//

import SwiftUI

// MARK: - Sheet with Wikipedia WebView
struct WikiInfoView: View {
    
    @State var urlString : String?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            dismissButton
            WebView(url: urlString?.getCleanedURL())
                .ignoresSafeArea(edges: .bottom)
        }
        .background(.thickMaterial)
    }
}

extension WikiInfoView {
    // MARK: - Dismiss Arrow Button
    private var dismissButton : some View {
        Button {
            dismiss()
        } label : {
            Image(systemName: K.Images.chevronLeft)
                .rotationEffect(Angle(degrees: -90))
                .font(.headline)
                .padding(8)
                .frame(maxWidth: .infinity)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(5)
                .shadow(radius: 4)
            
        }
    }
}

// MARK: - Preview
struct WikiInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WikiInfoView(urlString: "https://sr.wikipedia.org/wiki/Манастир_Жича")
    }
}
