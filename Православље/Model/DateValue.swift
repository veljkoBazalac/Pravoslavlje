//
//  DateValue.swift
//  Православље
//
//  Created by VELJKO on 16.10.22..
//

import Foundation

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day : Int
    var month : Int
    var date : Date
}
