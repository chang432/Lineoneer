//
//  ContentView.swift
//  Lineoneer
//
//  Created by Andre Chang on 3/29/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        switch viewRouter.currentPage {
            case 0:
                LoginView()
            case 1:
                MainView()
            default:
                LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ViewRouter())
    }
}
