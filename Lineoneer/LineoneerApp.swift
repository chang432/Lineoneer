//
//  LineoneerApp.swift
//  Lineoneer
//
//  Created by Andre Chang on 3/29/21.
//

import SwiftUI
import GoogleMaps

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("App has launched")
        GMSServices.provideAPIKey("AIzaSyBZwOAFTO81OZaU9g0fE1wvBruRpt0dX28")
        return true
    }
}

@main
struct LineoneerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewRouter)
        }
    }
}
