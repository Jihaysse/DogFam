//
//  Dog.swift
//  DoggoHome
//
//  Created by Julien Segers on 16/09/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import Foundation

struct Dog: Identifiable {
    
    var id = UUID()
    var name: String
    var race: String
    var age: Int
    var gender: String
    var sterile: Bool
    var pictureURL: String
    var location: String
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
     "AiredaleTerrier",
     "AkitaAmericain",
     "AkitaInu",
     "AmericanStaff",
     "Barbet",
     "BarbuTcheque",
     "Basenji",
     "Basset",
     "Beagle",
     "BeardedCollie",
     "Beauceron",
     "BergerAllemand",
     "BergerAustralien",
     "Groenendael",
     "BergerBelgeLaekenois",
     "Malinois",
     "Tervueren",
     "BergerBlancSuisse",
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
