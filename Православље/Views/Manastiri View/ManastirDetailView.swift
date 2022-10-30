//  ManastirDetailView.swift
//  Православље
//
//  Created by VELJKO on 2.10.22..

import SwiftUI
import MapKit
import CoreData

// MARK: - Sheet with Manastir Details
struct ManastirDetailView: View {
    
    @EnvironmentObject private var viewModel : ManastiriViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showWikiSheet : Bool = false
    let manastir : ManastirEntity
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment: .topLeading) {
            ArrowDownButton()
        }
        .sheet(isPresented: $showWikiSheet) {
            WikiInfoView(urlString: manastir.link)
        }
    }
        
}

extension ManastirDetailView {
    
    // MARK: - Image Section
    private var imageSection : some View {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.width * 0.6
        return Image(manastir.picture ?? "")
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .clipped()
        
    }
    
    // MARK: - Title Section
    private var titleSection : some View {
        VStack(alignment: .leading, spacing: 8) {
            if let manastirName = manastir.name {
                Text(manastirName)
                    .font(Font.custom(K.Fonts.clara, size: 35))
                    .fontWeight(.semibold)
            }
            
            if let eparhijaName = manastir.eparhija?.name {
                Text("Епархија \(eparhijaName)")
                    .font(Font.custom(K.Fonts.clara, size: 25))
                    .foregroundColor(.secondary)
            }
            
        }
    }
    
    // MARK: - Description Section
    private var descriptionSection : some View {
        VStack(alignment: .leading, spacing: 16) {
            if let about = manastir.about {
                Text(about)
                    .font(Font.custom(K.Fonts.clara, size: 18))
                    .foregroundColor(.secondary)
            }
            
            if manastir.link != nil {
                Text(K.Text.readMore)
                    .font(Font.custom(K.Fonts.clara, size: 18))
                    .foregroundColor(Color.blue)
                    .onTapGesture {
                        showWikiSheet = true
                    }
            }
        }
    }
}

// MARK: - Preview
struct ManastirDetailView_Previews: PreviewProvider {
    
    static let manastirEntity = NSManagedObjectModel.mergedModel(from: nil)?.entitiesByName["ManastirEntity"]
    
    static var previews: some View {
        previewView
            .padding()
    }

    static var previewView : some View {
        let manastir = ManastirEntity(entity: manastirEntity!, insertInto: nil)
        manastir.name = "Жича"
        manastir.picture = "zica"
        manastir.about = "Жича је српски средњовековни манастир из прве половине 13. века, који се налази у близини Краљева и припада Епархији жичкој Српске православне црква. Подигао ју је први краљ Србије из династије Немањића, Стефан Немањић (велики жупан 1196—1217, краљ 1217—1228), од 1206. до 1221. године. Стефан Првовенчани је такође наредио да се будући краљеви Србије крунишу у Жичи. Значајну улогу у подизању манастира имао је и његов брат, Свети Сава (1219—1233)."
        manastir.link = "https://sr.wikipedia.org/wiki/Манастир_Жича"
        manastir.latitude = 43.6954138846703
        manastir.longitude = 20.6459657244297
        manastir.eparhija?.name = "жичка"
        return ManastirDetailView(manastir: manastir)
    }
}
