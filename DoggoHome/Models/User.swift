//
//  User.swift
//  DoggoHome
//
//  Created by Julien Segers on 13/10/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import Foundation

struct User {
    
    let uuid = UUID().uuidString
    var name: String
    var surname: String
    var email: String
    var photoURL: String
    var reputation: Int
    var shelter: String
    
}
