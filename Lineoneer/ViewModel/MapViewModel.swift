import SwiftUI
import GoogleMaps
import CoreLocation

// All Map Data Goes Here....

class MapViewModel: NSObject,ObservableObject,CLLocationManagerDelegate{
    
    private let zoom: Float = 15.0
   
    @Published var mapView = GMSMapView()
   
    // Region...
    @Published var camera : GMSCameraPosition!
    // Based On Location It Will Set Up....
   
    // Alert...
    @Published var permissionDenied = false
   
    // Map Type...
    @Published var mapType : GMSMapViewType = GMSMapViewType.normal
   
    // SearchText...
    @Published var searchTxt = ""
   
    // Searched Places...
    @Published var places : [Place] = []
   
    // Updating Map Type...
   
    func updateMapType(){
       
        if mapType == GMSMapViewType.normal{
            mapType = GMSMapViewType.satellite
            mapView.mapType = mapType
        }
        else{
            mapType = GMSMapViewType.normal
            mapView.mapType = mapType
        }
    }
   
    // Focus Location...
   
    func focusLocation(){
       
        guard let _ = camera else{return}
       
        mapView.camera = camera
    }
   
    // Search Places...
   
//    func searchQuery(){
//
//        places.removeAll()
//
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = searchTxt
//
//        // Fetch...
//        MKLocalSearch(request: request).start { (response, _) in
//
//            guard let result = response else{return}
//
//            self.places = result.mapItems.compactMap({ (item) -> Place? in
//                return Place(placemark: item.placemark)
//            })
//        }
//    }
   
    // Pick Search Result...
   
//    func selectPlace(place: Place){
//
//        // Showing Pin On Map....
//
//        searchTxt = ""
//
//        guard let coordinate = place.placemark.location?.coordinate else{return}
//
//        let pointAnnotation = MKPointAnnotation()
//        pointAnnotation.coordinate = coordinate
//        pointAnnotation.title = place.placemark.name ?? "No Name"
//
//        // Removing All Old Ones...
//        mapView.removeAnnotations(mapView.annotations)
//
//        mapView.addAnnotation(pointAnnotation)
//
//        // Moving Map To That Location...
//
//        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
//
//        mapView.setRegion(coordinateRegion, animated: true)
//        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
//    }
   
   
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
       
        // Checking Permissions...
       
        switch manager.authorizationStatus {
        case .denied:
            // Alert...
            permissionDenied.toggle()
        case .notDetermined:
            // Requesting....
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            // If Permissin Given...
            manager.requestLocation()
        default:
            ()
        }
    }
   
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       
        // Error....
        print(error.localizedDescription)
    }
   
    // Getting user Region....
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        guard let location = locations.last else{return}
       
        self.camera = GMSCameraPosition(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: self.zoom)
       
        // Updating Map....
        self.mapView.animate(to: self.camera)
       
        // Smooth Animations...
//        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
}

