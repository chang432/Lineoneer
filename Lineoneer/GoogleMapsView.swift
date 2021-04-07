//
//  GoogleMapsView.swift
//  Lineoneer
//
//  Created by Andre Chang on 4/4/21.
//

import SwiftUI

import SwiftUI
import UIKit
import GoogleMaps

struct GoogleMapsView: UIViewRepresentable {
    @ObservedObject var locationManager = LocationManager()
    private let zoom: Float = 15.0
    
    //typealias UIViewType = UIImagePickerController
    func makeUIView(context: Self.Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.latitude, longitude: locationManager.longitude, zoom: zoom)
                let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
                return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: locationManager.latitude, longitude: locationManager.longitude))

    }
}

struct GoogleMapsView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMapsView()
    }
}
