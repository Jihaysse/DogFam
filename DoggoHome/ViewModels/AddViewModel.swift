//
//  AddViewModel.swift
//  DoggoHome
//
//  Created by Julien Segers on 19/09/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import Foundation
import SwiftUI

class AddViewModel: ObservableObject {
    
    @Published var dogs: [Dog] = []
    static var sharedInstance = AddViewModel()
    
}
