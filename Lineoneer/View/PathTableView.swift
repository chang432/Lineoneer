//
//  PathTableView.swift
//  Lineoneer
//
//  Created by Andre Chang on 4/27/21.
//

import SwiftUI
import Firebase

struct PathTableView: View {
    var body: some View {
        Text("Hello, World!")
        Button(action: {
            let db = Firestore.firestore()
            
            var ref: DocumentReference? = nil
            ref = db.collection("users").addDocument(data: [
                "first": "Bob",
                "last": "Smith",
                "born": 1998
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        }) {
            Text("Call Database")
        }
    }
}

struct PathTableView_Previews: PreviewProvider {
    static var previews: some View {
        PathTableView()
    }
}
