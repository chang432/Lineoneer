//
//  GeoLine.swift
//  GeoLine
//
//  Created by Ting-Han Tarn on 4/18/21.
//

import SwiftUI
import GoogleMaps
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("App has launched")
        FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyBZwOAFTO81OZaU9g0fE1wvBruRpt0dX28")
        return true
    }
}

@main
struct GeoLineApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            Home()
        }
    }
}
