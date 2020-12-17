//
//  HomeView.swift
//  DoggoHome
//
//  Created by Julien Segers on 15/09/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    @ObservedObject var addViewModel: AddViewModel = .sharedInstance
    @ObservedObject var user: UserAuth = .sharedInstance
    
    var body: some View {
        ZStack {
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack { // VStack so the CardView's shadow isn't cut off
                    if addViewModel.dogs.isEmpty {
                        Text("Pas de chiens à adopter!")
                        // TO DO: Ajouter une image stylée démontrant qu'il n'y a pas de chiens à adopter pour le moment.
                    }
                    ForEach(addViewModel.dogs) { dog in
                        CardView(dog: dog)
                    }
                }.padding(.horizontal, 10) // padding so the CardView's shadow isn't cut off
                .padding(.bottom, 70)

                
            }
//            .padding(.bottom, 75)
            VStack {
                Spacer()
                CustomTapBar()
            }.edgesIgnoringSafeArea(.bottom)
            
            
            
        }.onAppear() {
            self.addViewModel.fetchDogData()
            self.user.checkIfUserIsLoggedIn()
        }
        
    }
    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
