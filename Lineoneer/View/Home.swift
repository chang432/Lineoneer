import SwiftUI
import CoreLocation

struct Home: View {
   
    @StateObject var mapData = MapViewModel()
    // Location Manager....
    @State var locationManager = CLLocationManager()
    
    @State var headerText = ""
    @State var headerIndex = 0
    var headerTextList: [String] =
        ["",
         "Choose your starting location",
         "Choose your ending location",
         "Are you ready to start?",
         "In Progress"
        ]
   
    var body: some View {
       
        ZStack{
           
            // MapView...
            ZStack {
                MapView()
                    // using it as environment object so that it can be used ints subViews....
                    .environmentObject(mapData)
                    .ignoresSafeArea(.all, edges: .all)
                
                if headerIndex > 0 && headerIndex < 3{
                    Image("map_pin")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .scaledToFit()
                        .offset(y: 20)
                        .background(Color.clear)
                }
            }
           
            VStack{
               
                Spacer()
               
                VStack{
                   
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button(action: mapData.updateMapType, label: {
                           
                            Image(systemName: mapData.mapType == .normal ? "network" : "map")
                                .font(.title2)
                                .padding(10)
                                .background(Color.primary)
                                .clipShape(Circle())
                        })
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            self.headerIndex += 1
                            
                            // reset if at end
                            if self.headerIndex >= self.headerTextList.count {
                                self.headerIndex = 0
                            }
                            
                            // update header text
                            self.headerText = self.headerTextList[self.headerIndex]
                            
                            // set start marker
                            switch self.headerIndex {
                            case 2:
                                self.mapData.startMarker.position = self.mapData.mapView.camera.target
                                self.mapData.startMarker.map = self.mapData.mapView
                            
                            
                            // set end marker and draw line
                            case 3:
                                self.mapData.endMarker.position = self.mapData.mapView.camera.target
                                self.mapData.endMarker.map = self.mapData.mapView
                                
                                mapData.drawLine()
                            
                            // start tracking route
                            case 4:
                                self.mapData.trackingRoute = true
                            
                            // reset everything
                            case 0:
                                self.mapData.mapView.clear()
                                self.mapData.planPath.removeAllCoordinates()
                                self.mapData.routePath.removeAllCoordinates()
                                self.mapData.trackingRoute = false
                            
                            default:
                                return
                            }
                            
                        }) {
                            Text("Start")
                        }
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color.white)
                        .background(Circle().fill(Color.green).shadow(radius: 3))
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
            
            VStack {
                if headerText != "" {
                    Text(headerText)
                        .font(.title)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .frame(width: 300, height: 60)
                        .background(Rectangle().fill(Color.green).shadow(radius: 3))
                }
                Spacer()
            }
        }
        .onAppear(perform: {
            print("on appearing")
            // Setting Delegate...
            locationManager.delegate = mapData
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
            // focus on launch
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                mapData.focusLocation()
            }
        })
        // Permission Denied Alert...
        .alert(isPresented: $mapData.permissionDenied, content: {
           
            Alert(title: Text("Permission Denied"), message: Text("Please Enable Permission In App Settings"), dismissButton: .default(Text("Goto Settings"), action: {
               
                // Redireting User To Settings...
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
        })
//        .onChange(of: mapData.searchTxt, perform: { value in
//
//            // Searching Places...
//
//            // You can use your own delay time to avoid Continous Search Request...
//            let delay = 0.3
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//
//                if value == mapData.searchTxt{
//
//                    // Search...
////                    self.mapData.searchQuery()
//                }
//            }
//        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
