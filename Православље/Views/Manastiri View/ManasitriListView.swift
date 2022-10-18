//
//  ManasitriListView.swift
//  Православље
//
//  Created by VELJKO on 23.9.22..
//

import SwiftUI

struct ManastiriListView: View {

    @EnvironmentObject private var viewModel : ManastiriViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(viewModel.eparhijeArray) { eparhija in
                    VStack(spacing: 5) {
                        eparhijaName(eparhija: eparhija)
                        rectangleSection(eparhija: eparhija)
                        Divider()
                            .padding(.horizontal)
                    }
                    .frame(height: 120)
                    .background(Color.clear)
                }
            }
            .frame(height: 500)
        }
    }
}

extension ManastiriListView {
    
    // MARK: - Eparhija Name
    private func eparhijaName(eparhija: EparhijaEntity) -> some View {
        if let eparhija = eparhija.name {
           return Text("Eпархија \(eparhija)")
                .font(Font.custom("CormorantSC-Bold", size: 20))
        } else {
            return Text("")
        }
    }
    
    // MARK: - Rounded Rectangle
    private func rectangleSection(eparhija: EparhijaEntity) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(viewModel.manastiriArray) { manastir in
                    if eparhija.name == manastir.eparhija?.name {
                        VStack(spacing: 10) {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 80, height: 50)
                                .overlay {
                                    if let picture = manastir.picture {
                                        Image(picture)
                                            .resizable()
                                            .cornerRadius(10)
                                            .shadow(color: Color.black.opacity(0.3),
                                                    radius: 3,
                                                    x: 0,
                                                    y: 5)
                                        
                                    }
                                }
                                .padding(.horizontal)
                            
                            if let name = manastir.name {
                                Text(name)
                                    .font(Font.custom("CormorantSC-Medium", size: 15))
                            }
                        }
                        .onTapGesture {
                            viewModel.showNextLocation(location: manastir)
                        }
                    }
                }
            }
        }
    }
    
}

struct ManastiriListView_Previews: PreviewProvider {
    
    static var previews: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()
            ManastiriListView()
        }
        .environmentObject(ManastiriViewModel())
    }
}
