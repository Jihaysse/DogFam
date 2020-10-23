//
//  ViewRouter.swift
//  DoggoHome
//
//  Created by Julien Segers on 23/09/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ViewRouter: ObservableObject {
     
    @Published var currentView: String = "Home"
    static var sharedInstance = ViewRouter()
}
