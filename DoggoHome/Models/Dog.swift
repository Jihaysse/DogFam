//
//  Dog.swift
//  DoggoHome
//
//  Created by Julien Segers on 16/09/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import Foundation

struct Dog: Identifiable {
    
    let id = UUID().uuidString
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
     "Malinois",
     "Tervueren",
     "Berger Blanc Suisse",
     "BergerCatalan",
     "BergerAnatolie",
     "BergerPyrenees",
     "BergerShetland",
     "BergerCaucase",
     "BergerHollandais",
     "BergerYougoslave",
     "Bichon",
     "Yorkshire",
     "Bobtail",
     "Boerbull",
     "BorderCollie",
     "BostonTerrier",
     "BouledogueAmericain",
     "BouledogueFrancais",
     "BouvierAustralien",
     "BouvierBernois",
     "BouvierFlandres",
     "Boxer",
     "BraqueAllemand",
     "BraqueWeimar",
     "BraqueHongrois",
     "BullTerrier",
     "BouledogueAnglais",
     "BullMastiff"
]
