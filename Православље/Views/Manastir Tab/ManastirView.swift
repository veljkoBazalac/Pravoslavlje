//
//  ManastirView.swift
//  Pravoslavlje
//
//  Created by VELJKO on 23.7.22..
//

import SwiftUI

struct ManastirView: View {
    
    var imageString: String?
    var aboutString: String?
    
    var body: some View {
        ScrollView {
            VStack {
                if imageString != nil {
                    Image(imageString!)
                        .resizable()
                        .padding()
                        .frame(width: 300, height: 300, alignment: .center)
                        .scaledToFill()
                        .clipped()
                }
                Spacer()
                if aboutString != nil {
                    Text(aboutString!)
                        .padding()
                }
            }
        }
    }
}

struct ManastirView_Previews: PreviewProvider {
    static var previews: some View {
        ManastirView(imageString: "default", aboutString: "")
    }
}
