//
//  ManastirPreviewView.swift
//  Православље
//
//  Created by VELJKO on 24.9.22..
//

import SwiftUI
import CoreData

// MARK: - Preview of the Manastir
struct ManastirPreviewView: View {
    
    @EnvironmentObject private var viewModel : ManastiriViewModel
    let manastir : ManastirEntity
    @State private var showDetailSheet : Bool = false
    // Save User Navigation App Selection
    @AppStorage("NAVIGATION_APP") var navigationApp : String?
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            VStack(alignment: .leading) {
                imageSection
                Spacer()
                nameSection
            }
            Spacer()
            navButton
                .padding(.vertical, 15)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .frame(height: 250)
        .cornerRadius(10)
        .sheet(isPresented: $showDetailSheet, content: {
            ManastirDetailView(manastir: manastir)
        })
    }
}

extension ManastirPreviewView {
    
    // MARK: - Manastir Image section
    private var imageSection : some View {
        ZStack {
            if let manastirPicture = manastir.picture {
                Image(manastirPicture)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3),
                radius: 3,
                x: 0,
                y: 5)
        .onTapGesture {
            showDetailSheet = true
        }
    }
    
    // MARK: - Manastir name and eparhija section
    private var nameSection : some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(manastir.name ?? "")
                .lineLimit(1)
                .font(Font.custom("CormorantSC-Bold", size: 30))
                .minimumScaleFactor(0.7)
            
            if let eparhijaName = manastir.eparhija?.name {
                Text("Епархија \(eparhijaName)")
                    .lineLimit(2)
                    .font(Font.custom("CormorantSC-Medium", size: 20))
                    .minimumScaleFactor(0.5)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Navigation Button
    private var navButton : some View {
        VStack {
            // Button
            Button {
                if navigationApp == nil {
                    viewModel.openGoogleMaps()
                } else if navigationApp == "Google" {
                    viewModel.openGoogleMaps()
                } else if navigationApp == "Apple" {
                    viewModel.openAppleMaps()
                }
            } label: {
                VStack {
                    Image("navigation")
                        .resizable()
                        .frame(width: 45, height: 50)
                        .foregroundColor(Color("NavigationColor"))
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 3,
                                x: 0,
                                y: 5)
                    
                    
                }
            }
            .contextMenu(menuItems: {
                // Apple Maps
                Button {
                    viewModel.openAppleMaps()
                } label: {
                    HStack {
                        Text("Apple Maps")
                        Image("appleMaps")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFit()
                            .shadow(radius: 10)
                    }
                }
                
                // Google Maps
                Button {
                    viewModel.openGoogleMaps()
                } label: {
                    HStack {
                        Text("Google Maps")
                        Image("googleMaps")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFit()
                            .shadow(radius: 10)
                    }
                }
            })
        }
    }
}

// MARK: - Preview
struct ManastirPreviewView_Previews: PreviewProvider {
    
    static let manastirEntity = NSManagedObjectModel.mergedModel(from: nil)?.entitiesByName["ManastirEntity"]
    
    static var previews: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()
            previewView
                .padding()
        }
        .environmentObject(ManastiriViewModel())
    }
    
    static var previewView : some View {
        let manastir = ManastirEntity(entity: manastirEntity!, insertInto: nil)
        manastir.name = "Жича"
        manastir.picture = "zica"
        manastir.eparhija?.name = "жичка"
        
        return ManastirPreviewView(manastir: manastir)
    }
}
