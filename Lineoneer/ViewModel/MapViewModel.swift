import SwiftUI
import GoogleMaps
import CoreLocation

// All Map Data Goes Here....

class MapViewModel: NSObject,ObservableObject,CLLocationManagerDelegate{
    
    private let zoom: Float = 15.0
    
    @Published var location = CLLocation()
   
    @Published var mapView = GMSMapView()
   
    // Region...
    @Published var camera : GMSCameraPosition!
    // Based On Location It Will Set Up....
   
    // Alert...
    @Published var permissionDenied = false
   
    // Map Type...
    @Published var mapType : GMSMapViewType = GMSMapViewType.normal
   
    // Searched Places...
    @Published var places : [Place] = []
    
    // markers for line
    @Published var startMarker = GMSMarker()
    @Published var endMarker = GMSMarker()
    
    // store planned line
    var planPath = GMSMutablePath()
    @Published var planLine = GMSPolyline()
    
    // store actual route
    @Published var trackingRoute = false
    var routePath = GMSMutablePath()
    @Published var routeLine = GMSPolyline()
    
   
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
    
    func drawLine(){
        planPath.add(startMarker.position)
        planPath.add(endMarker.position)
        planLine.path = planPath
        planLine.map = mapView
        
        // animate camera to fit line on screen
        var bounds = GMSCoordinateBounds()

        for index in 0...planPath.count() {
            bounds = bounds.includingCoordinate(planPath.coordinate(at: index))
        }
        
        // if bounds is taller than it is wide, pad space at top by x%
        let height = abs(bounds.northEast.latitude - bounds.southWest.latitude)
        let width = abs(bounds.northEast.longitude - bounds.southWest.longitude)
        if height > width {
            var upperPoint = mapView.projection.point(for: bounds.northEast)
            upperPoint.y = upperPoint.y * 0.9
            let upperCoord = mapView.projection.coordinate(for: upperPoint)
            
            var lowerPoint = mapView.projection.point(for: bounds.southWest)
            lowerPoint.y = lowerPoint.y * 1.2
            let lowerCoord = mapView.projection.coordinate(for: lowerPoint)
            
            bounds = GMSCoordinateBounds.init(coordinate: upperCoord, coordinate: lowerCoord)
        }

        CATransaction.begin()
        CATransaction.setAnimationDuration(CFTimeInterval(1.5))
        self.mapView.animate(with: GMSCameraUpdate.fit(bounds))
        // what to do when animation complete
//        CATransaction.setCompletionBlock {
//        }
        CATransaction.commit()
    }
   
    // Focus Location...
   
    func focusLocation(){
        
        print("focusing location")
        let camera = GMSCameraPosition(latitude: self.location.coordinate.latitude, longitude: self.location.coordinate.longitude, zoom: self.zoom)
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
       
//        guard let location = locations.last else{return}
        if locations.last == nil {
            return
        } else {
            self.location = locations.last!
            print("updating location")
        }
        
        // tracking route
        if self.trackingRoute {
            self.routePath.add(self.location.coordinate)
            self.routeLine.path = routePath
            self.routeLine.map = self.mapView
        }
    }
}

