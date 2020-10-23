//
//  UserAuth.swift
//  DoggoHome
//
//  Created by Julien Segers on 23/09/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import Combine
import Firebase
import SwiftUI

class UserAuth: ObservableObject {
    
    //MARK: - Properties
    
    @Published var isLoggedin: Bool = false
    
    static var sharedInstance = UserAuth()
    
    var viewRouter: ViewRouter = .sharedInstance
    
    @State private var errorText: String = ""
    @Published var showAlert: Bool = false

    
    //MARK: - Functions
    

    
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard let user = result?.user, error == nil else {
                let errorText: String = error?.localizedDescription ?? "Erreur inconnue"
                self.errorText = errorText
                return
            }
        }
    }
    
    
    func signIn(email: String, password: String) {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    self.errorText = error.localizedDescription
                    self.showAlert = true
                    print(error.localizedDescription)
                    return
                }
                guard result != nil else { return }
                self.showAlert = false
                self.checkIfUserIsLoggedIn()
        }
    }
    
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser != nil {
            // User is signed in
            self.isLoggedin = true
            self.viewRouter.currentView = "Home"
        } else {
            // No user is signed in
            self.isLoggedin = false
            self.viewRouter.currentView = "Home"
        }
    }

    
    func logOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        self.checkIfUserIsLoggedIn()
    }
}
