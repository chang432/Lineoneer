//
//  Place.swift
//  Lineoneer
//
//  Created by Ting-Han Tarn on 4/18/21.
//

import SwiftUI
import MapKit

struct Place: Identifiable {
   
    var id = UUID().uuidString
    var placemark: CLPlacemark
}
