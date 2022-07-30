//
//  PraznikView.swift
//  Pravoslavlje
//
//  Created by VELJKO on 30.7.22..
//

import SwiftUI

struct PraznikView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var selectedDay : String 
    
    var body: some View {
        Text(selectedDay)
    }
}

struct PraznikView_Previews: PreviewProvider {
    static var previews: some View {
        PraznikView(selectedDay: "")
    }
}
