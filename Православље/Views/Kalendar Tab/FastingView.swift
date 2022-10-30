//
//  FastingView.swift
//  Православље
//
//  Created by VELJKO on 18.10.22..
//

import SwiftUI

// MARK: - PopUp View with Fasting rules
struct FastingView: View {
    
    @Binding var showView : Bool
    
    var body: some View {
        ZStack(alignment:.center) {
            if showView {
                // Background
                Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            self.showView = false
                        }
                    }
                // Text
                textData
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.ultraThinMaterial)
                    )
            }
        }
    }
}

extension FastingView {
    
    // MARK: - Add Symbol Function to explain Fasting
    private func addSymbol(color: String, title: String, text: String) -> some View {
        VStack(alignment: .leading) {
            HStack {
                // Rounded Rectangle with Color
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color(color))
                    .frame(width: 20, height: 20)
                // Name of Fasting Type
                Text("- \(title)")
                    .font(Font.custom(K.Fonts.clara, size: 20))
            }
            // Fasting explanation
            Text(text)
                .font(Font.custom(K.Fonts.clara, size: 20))
        }
    }
    
    // MARK: - Text Data with Fasting explanation
    private var textData : some View {
        VStack {
            Text(K.Fasting.Title.napomene)
                .font(Font.custom(K.Fonts.clara, size: 25))
            
            VStack(alignment: .leading) {
                // Potpuni post
                addSymbol(color: K.Colors.potpuniPost,
                          title: K.Fasting.Title.potpuniPost,
                          text: K.Fasting.Text.potpuniPost)
                // Voda
                addSymbol(color: K.Colors.voda,
                          title: K.Fasting.Title.voda,
                          text: K.Fasting.Text.voda)
                // Vino
                addSymbol(color: K.Colors.vino,
                          title: K.Fasting.Title.vino,
                          text: K.Fasting.Text.vino)
                // Ulje
                addSymbol(color: K.Colors.ulje,
                          title: K.Fasting.Title.ulje,
                          text: K.Fasting.Text.ulje)
                // Riba
                addSymbol(color: K.Colors.riba,
                          title: K.Fasting.Title.riba,
                          text: K.Fasting.Text.riba)
                // Beli mrs
                addSymbol(color: K.Colors.beliMrs,
                          title: K.Fasting.Title.beliMrs,
                          text: K.Fasting.Text.beliMrs)
            }
        }
        .padding()
    }
}

// MARK: - Preview
struct FastingView_Previews: PreviewProvider {
    static var previews: some View {
        FastingView(showView: .constant(true))
    }
}
