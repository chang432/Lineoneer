//
//  LoginView.swift
//  Lineoneer
//
//  Created by Andre Chang on 3/30/21.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            Text("Welcome to Lineoneer")
                .padding()
                .foregroundColor(.green)
                .font(.largeTitle)
            Spacer()
            Button(action: {
                viewRouter.currentPage = 1
            }) {
                Text("Start")
            }
        }
        .padding(.bottom, 250)
        .padding(.top, 100)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(ViewRouter())
    }
}
