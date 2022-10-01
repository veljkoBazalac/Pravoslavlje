//
//  ManasitriListView.swift
//  Православље
//
//  Created by VELJKO on 23.9.22..
//

import SwiftUI

//struct ManastiriListView: View {
//
//    @EnvironmentObject private var vm : ManastiriViewModel
//
//    var body: some View {
//        List {
//            ForEach(vm.locations) { location in
//                Button {
//                    vm.showNextLocation(location: location)
//                } label: {
//                    listRowView(location: location)
//                }
//                .padding(.vertical, 4)
//                .listRowBackground(Color.clear)
//            }
//        }
//        .listStyle(PlainListStyle())
//    }
//}
//
//extension ManastiriListView {
//
//    private func listRowView(location: ManastirEntity) -> some View {
//        HStack {
//            if let imageName = location.imageNames.first {
//                Image(imageName)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 45, height: 45)
//                    .cornerRadius(10)
//            }
//
//            VStack(alignment: .leading) {
//                Text(location.name)
//                    .font(.headline)
//                Text(location.cityName)
//                    .font(.subheadline)
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//        }
//    }
//}
//
//struct ManastiriListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ManastiriListView()
//            .environmentObject(ManastiriViewModel())
//    }
//}
