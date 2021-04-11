//
//  GoogleMapsView.swift
//  Lineoneer
//
//  Created by Andre Chang on 4/4/21.
//

import SwiftUI
import UIKit
import GoogleMaps


struct GoogleMapsView: UIViewRepresentable {
    @EnvironmentObject var gmapsRouter: GoogleMapsRouter
    
    // 1
    @ObservedObject var locationManager = LocationManager()
    private let zoom: Float = 15.0
    private let path: GMSMutablePath = GMSMutablePath()
    
    // 2
    func makeUIView(context: Self.Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.latitude, longitude: locationManager.longitude, zoom: zoom)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        //center on current location
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: locationManager.latitude, longitude: locationManager.longitude))
        
        return mapView
    }
    
    // 3
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        if gmapsRouter.showLine == false {
            mapView.clear()
        } else {
            // draw trail
            path.add(CLLocationCoordinate2D(latitude: locationManager.latitude, longitude: locationManager.longitude))
            let polyline = GMSPolyline(path: path)
            polyline.map = mapView
            
            print(path)
        }
    }
    
    
}
