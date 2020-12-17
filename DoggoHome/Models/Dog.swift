//
//  Dog.swift
//  DoggoHome
//
//  Created by Julien Segers on 16/09/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import Foundation

struct Dog: Identifiable {
    
    let id: String
    var userID: String
    var name: String
    var race: String
    var age: Int
    var gender: String
    var sterile: Bool
    var pictureURL: String
    var shelter: Shelter?
    var address: String?
    var phoneNumber: String?
    var description: String?
    var dogFriendly: Bool
    var catFriendly: Bool
    var childFriendly: Bool
    var needsGarden: Bool
    var isClean: Bool
    
}



let genders = ["Male", "Femelle"]

let races = [
     "Inconnue",
     "Affenpinscher",
     "Airedale Terrier",
     "Akita Americain",
     "Akita Inu",
     "American Staff",
     "Barbet",
     "Barbu Tcheque",
     "Basenji",
     "Basset",
     "Beagle",
     "Bearded Collie",
     "Beauceron",
     "Berger Allemand",
     "Berger Australien",
     "Groenendael",
     "Berger Belge Laekenois",
     "Berger Malinois",
     "Berger Tervueren",
     "Berger Blanc Suisse",
     "Berger Catalan",
     "Berger Anatolie",
     "Berger Pyrenees",
     "Berger Shetland",
     "Berger Caucase",
     "Berger Hollandais",
     "Berger Yougoslave",
     "Bichon",
     "Yorkshire",
     "Bobtail",
     "Boerbull",
     "Border Collie",
     "Boston Terrier",
     "Bouledogue Americain",
    "Bouledogue Anglais",
     "Bouledogue Francais",
     "Bouvier Australien",
     "Bouvier Bernois",
     "Bouvier Flandres",
     "Boxer",
     "Braque Allemand",
     "Braque Weimar",
     "Braque Hongrois",
    "Bull Mastiff",
     "Bull Terrier"
]
