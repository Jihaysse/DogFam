//
//  AddViewModel.swift
//  DoggoHome
//
//  Created by Julien Segers on 19/09/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

class AddViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var dogs: [Dog] = []
    @Published var currentUserDogs: [Dog] = []
    static var sharedInstance = AddViewModel()
    var db = Firestore.firestore()
    
    //MARK: - Actions
    
//    func getDogData() {
//        db.collection("dogs").getDocuments() { (snapshot, error) in
//            if let err = error {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in snapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                    let dog = Dog(name: document.get("name") as! String,
//                                  race: document.get("race") as! String,
//                                  age: document.get("age") as! Int,
//                                  gender: document.get("gender") as! String,
//                                  sterile: document.get("sterile") as! Int == 1 ? true : false,
//                                  pictureURL: document.get("pictureURL") as! String,
//                                  location: document.get("location") as! String,
//                                  phoneNumber: document.get("phoneNumber") as! String,
//                                  dogFriendly: document.get("dogFriendly") as! Int == 1 ? true : false,
//                                  catFriendly: document.get("catFriendly") as! Int == 1 ? true : false,
//                                  childFriendly: document.get("childFriendly") as! Int == 1 ? true : false,
//                                  needsGarden: document.get("needsGarden") as! Int == 1 ? true : false,
//                                  isClean: document.get("isClean") as! Int == 1 ? true : false)
//                    self.dogs.append(dog)
//                }
//            }
//        }
//    }
    
    func fetchDogData() {
        db.collection("dogs").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("DEBUG: No documents")
                return
            }
            
            self.dogs = documents.map({ (queryDocumentSnapshot) -> Dog in
                let data = queryDocumentSnapshot.data()
                let userID = data["userID"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let race = data["race"] as? String ?? ""
                let age = data["age"] as? Int ?? 1
                let gender = data["gender"] as? String ?? ""
                let sterile = data["sterile"] as! Int == 1 ? true : false
                let pictureURL = data["pictureURL"] as? String ?? ""
                let shelter = data["shelter"] as? Shelter ?? nil
                let address = data["address"] as? String ?? ""
                let phoneNumber = data["phoneNumber"] as? String ?? ""
                let dogFriendly = data["dogFriendly"] as! Int == 1 ? true : false
                let catFriendly = data["catFriendly"] as! Int == 1 ? true : false
                let childFriendly = data["childFriendly"] as! Int == 1 ? true : false
                let needsGarden = data["needsGarden"] as! Int == 1 ? true : false
                let isClean = data["isClean"] as! Int == 1 ? true : false
                
                return Dog(userID: userID, name: name, race: race, age: age, gender: gender, sterile: sterile, pictureURL: pictureURL, shelter: shelter, address: address, phoneNumber: phoneNumber, dogFriendly: dogFriendly, catFriendly: catFriendly, childFriendly: childFriendly, needsGarden: needsGarden, isClean: isClean)
            })
        }
        
        
        
    }
    
    
    
    
    
}
