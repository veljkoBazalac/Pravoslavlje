//
//  ManastirPreviewView.swift
//  Православље
//
//  Created by VELJKO on 24.9.22..
//

import SwiftUI
import CoreData

struct ManastirPreviewView: View {
    
    @EnvironmentObject private var vm : ManastiriViewModel
    let manastir : ManastirEntity
    let eparhija : String?
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            VStack(alignment: .leading) {
                imageSection
                Spacer()
                nameSection
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                navButton
                    .padding(.vertical, 15)
                Spacer()
                infoButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .frame(height: 250)
        .cornerRadius(10)
    }
}

extension ManastirPreviewView {
    
    // MARK: - Manastir Image section
    private var imageSection : some View {
        ZStack {
            if let imageName = manastir.picture {
                Image(imageName)
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
    }
    
    // MARK: - Manastir name and eparhija section
    private var nameSection : some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(manastir.name ?? "-")
                .font(Font.custom("CormorantSC-Bold", size: 30))
            
            HStack(spacing: 4) {
                if let eparhija = eparhija {
                    Text("Епархија \(eparhija)")
                        .lineLimit(2)
                        .font(Font.custom("CormorantSC-Medium", size: 20))
                        .minimumScaleFactor(0.7)
                }
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Navigation Button
    private var navButton : some View {
        Button {
            print("NAV")
        } label: {
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
    
    // MARK: - Info Button
    private var infoButton : some View {
        Button {
            vm.sheetLocation = manastir
        } label: {
            Text("Информације")
                .frame(width: 120, height: 40)
                .font(Font.custom("CormorantSC-Bold", size: 18))
                .minimumScaleFactor(0.5)
                .foregroundColor(Color.white)
                .background(Color("NavigationColor"))
                .cornerRadius(10)
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
    }
    
    static var previewView : some View {
        let manastir = ManastirEntity(entity: manastirEntity!, insertInto: nil)
        manastir.name = "Жича"
        manastir.picture = "zica"

        return ManastirPreviewView(manastir: manastir, eparhija: "жичка")
    }
}


