//
//  LaunchScreen.swift
//  Православље
//
//  Created by VELJKO on 30.10.22..
//

import SwiftUI

struct LaunchScreen: View {
    
    @State private var showManastiriView : Bool = false
    
    var body: some View {
        if showManastiriView {
            ManastiriView()
        } else {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(K.Colors.launchScreen1), Color(K.Colors.launchScreen2)]),
                    startPoint: .top,
                    endPoint: .bottom)
                .ignoresSafeArea()
                
                VStack(spacing: 50) {
                    Image(K.Images.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 250)
                        .shadow(radius: 5)
                    
                    Text(K.Text.pravoslavlje)
                        .font(.custom(K.Fonts.cormorantBold, size: 40))
                        .foregroundColor(Color.white)
                        .shadow(radius: 3)
                }
                .offset(y: -100)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation(.easeInOut(duration: 2)) {
                        showManastiriView = true
                    }
                }
            }
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
