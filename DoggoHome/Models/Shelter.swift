//
//  Shelter.swift
//  DoggoHome
//
//  Created by Julien Segers on 13/10/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import Foundation

struct Shelter {
    
    let uuid = UUID().uuidString
    var name: String
    var address: String
    var phoneNumber: String?
    var members: [User?]
    var dogs: [Dog?]
    var description: String?
    var website: URL?
    
}

var shelters = [
    "Aucun",
    sansCollierASBL.name,
"Un Toit Pour Eux",
    "Blablabla",
    "Jsp trop",
    "nananananaa",
    "gfajiogieja"
]

var sansCollierASBL = Shelter(name: "Sans Collier ASBL", address: "", phoneNumber: "", members: [], dogs: [], description: "", website: nil)
