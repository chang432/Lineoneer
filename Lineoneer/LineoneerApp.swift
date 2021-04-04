//
//  LineoneerApp.swift
//  Lineoneer
//
//  Created by Andre Chang on 3/29/21.
//

import SwiftUI

@main
struct LineoneerApp: App {
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewRouter)
        }
    }
}
