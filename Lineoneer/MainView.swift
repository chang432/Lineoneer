//
//  MainView.swift
//  Lineoneer
//
//  Created by Andre Chang on 3/30/21.
//

import SwiftUI
import UIKit
import GoogleMaps

struct MainView: View {
    var body: some View {
        ZStack {
            GoogleMapsView()
                .edgesIgnoringSafeArea(.top)
            VStack {
                Spacer()
                Button(action: {
                    GoogleMapsView().path.map.clear()
                }) {
                    ZStack{
                       Circle()
                       .frame(width: 100, height: 100)
                       .foregroundColor(.yellow)
                       Text("Press me")
                   }.frame(width: 300, height: 50)
                }.padding(.bottom, 60)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
