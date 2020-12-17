//
//  ProfileViewModel.swift
//  DoggoHome
//
//  Created by Julien Segers on 11/11/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import Foundation
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    
    //MARK: - Properties
    
    static var sharedInstance = ProfileViewModel()
    var db = Firestore.firestore()
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var reputation: Int = 0
    @Published var imageURL: String = ""

    //MARK: - Actions
    
    func fetchProfileData(uid: String) {
        db.collection("profiles").document(uid).getDocument { (document, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            if let document = document, document.exists {
                if let name = document.get("name") as? String {
                    self.firstName = name
                }
                if let surname = document.get("surname") as? String {
                    self.lastName = surname
                }
                if let reput = document.get("reputation") as? Int {
                    self.reputation = reput
                }
            }
        }
    }
    
    
    func fetchProfileImageURL(uid: String) -> String {
        db.collection("profiles").document(uid).getDocument { (document, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            if let document = document, document.exists {
                if let photoURL = document.get("photoURL") as? String {
                    self.imageURL = photoURL
                }
                print("IMAGE URL is : \(self.imageURL)")
            }
        }
        return self.imageURL
    }
    
    
    func updateProfileData(uid: String, name: String, surname: String) {
        db.collection("profiles").document(uid).updateData(["name": name,
                                                                         "surname": surname])
    }
    
    
    func updateProfilePicture(uid: String, newImgURL: String) {
        db.collection("profiles").document(uid).updateData(["photoURL": newImgURL]) { error in
            if let err = error {
                print("Error updating profile picture: \(err.localizedDescription)")
                return
            }
            self.fetchProfileImageURL(uid: uid)
        }
    }
    

    
}
