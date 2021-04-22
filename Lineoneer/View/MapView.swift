import SwiftUI
import GoogleMaps

struct MapView: UIViewRepresentable {
   
    @EnvironmentObject var mapData: MapViewModel

//    func makeCoordinator() -> Coordinator {
//        return MapView.Coordinator()
//    }
   
    func makeUIView(context: Context) -> GMSMapView {
       
        let view = mapData.mapView
       
        view.isMyLocationEnabled = true
        view.settings.myLocationButton = true
        
        // use view.padding to change region for compassButton
        view.settings.compassButton = true
//        view.delegate = context.coordinator
        
        view.paddingAdjustmentBehavior = GMSMapViewPaddingAdjustmentBehavior.never
        view.padding = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        
        print("return view")
       
        return view
    }
   
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        
    }
   
//    class Coordinator: NSObject,MKMapViewDelegate{
//
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//            // Custom Pins....
//
//            // Excluding User Blue Circle...
//
//            if annotation.isKind(of: MKUserLocation.self){return nil}
//            else{
//                let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PIN_VIEW")
//                pinAnnotation.tintColor = .red
//                pinAnnotation.animatesDrop = true
//                pinAnnotation.canShowCallout = true
//
//                return pinAnnotation
//            }
//        }
//    }
}

