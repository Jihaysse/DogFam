//
//  ContentView.swift
//  DoggoHome
//
//  Created by Julien Segers on 15/09/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewRouter: ViewRouter = .sharedInstance
 
    var body: some View {
        if self.viewRouter.currentView == "Home" {
            HomeView()
        } else if self.viewRouter.currentView == "Profile" {
            ProfileView()
        } else if self.viewRouter.currentView == "Login" {
            LoginView()
        } else if self.viewRouter.currentView == "ProfileSettings" {
            ProfileSettingsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
