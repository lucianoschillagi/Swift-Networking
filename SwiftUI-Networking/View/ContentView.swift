//
//  ContentView.swift
//  SwiftUI-Networking
//
//  Created by Luko on 13/11/2020.
//

import SwiftUI

// The View
struct ContentView: View {
    
    @ObservedObject private var observer = Observer() // Publisher 📝
    
    var body: some View { // Subscriptor 👁
        NavigationView {
            List(observer.users, id: \.self) { user in
                
                // List Item
                HStack {
                    //RemoteImage(url: organization.avatarUrl)
                       // .aspectRatio(contentMode: .fit)
                      //  .frame(width: 30)
                    Text(user.firstName)
                    Text(String(user.needs.medicalHelp))
                }
                // End List Item
                
            }.navigationBarTitle("Users List")
        }
    }
}

// MARK: Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
