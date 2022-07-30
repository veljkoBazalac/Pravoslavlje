//
//  ManastirListView.swift
//  Pravoslavlje
//
//  Created by VELJKO on 23.7.22..
//

import SwiftUI

struct ManastirListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var manastiri: FetchedResults<Manastir>
    
    var body: some View {
             
        VStack {
            NavigationView {
                List(manastiri) { manastir in
                    NavigationLink(destination: ManastirView(imageString: manastir.picture, aboutString: manastir.about)) {
                        
                        Text(manastir.name ?? "Unknown")
                            .font(Font.custom("CormorantSC-Medium", size: 30))
                            .navigationTitle("Манастири")
                        
                    }
                }
                .padding()
            }
        }
    }
}

struct ManastirListView_Previews: PreviewProvider {
    static var previews: some View {
        ManastirListView()
    }
}
