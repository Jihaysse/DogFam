//
//  ImageStorage.swift
//  DoggoHome
//
//  Created by Julien Segers on 30/10/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import Foundation
import Firebase
import SwiftUI

class ImageStorage {
    
    //MARK: - Properties
    
    let storage = Storage.storage()
    @Published var imageURL = ""


    
    //MARK: - Actions
    
    func uploadImageToFirestore(id: String, image: UIImage, completion: @escaping () -> Void) {
        let storageRef = storage.reference().child("images/\(id)/image.jpg").putData(image.jpegData(compressionQuality: 0.35)!, metadata: nil) { (_, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            print("Success uploading picture to Firestore")
            completion()
        }
    }
    
    
    func downloadImageFromFirestore(id: String, completion: @escaping (_ url: String) -> Void) {
        let storageRef = storage.reference().child("images/\(id)/image.jpg")
        storageRef.downloadURL { url, error in
            if error != nil {
                print("DEBUG: \((error?.localizedDescription)!)")
                return
            }
            print("Success downloading picture from Firestore")
            self.imageURL = "\(url!)"
            completion(self.imageURL)



        }
    }
    
    
    func uploadDogImageToFirestore(dogID: String, image: UIImage, completion: @escaping () -> Void) {
        // TO DO
        let storageRef = storage.reference().child("dogs/\(dogID)/image.jpg").putData(image.jpegData(compressionQuality: 0.35)!, metadata: nil) { (_, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            print("Success uploading dog picture to firestore")
            completion()
        }
    }
    
    func downloadDogImageFromFirestore(dogID: String, completion: @escaping (_ url: String) -> Void) {
        let storageRef = storage.reference().child("dogs/\(dogID)/image.jpg")
        storageRef.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            self.imageURL = "\(url!)"
            completion(self.imageURL)
        }

    }
    
    
    
}
