//
//  HomeView.swift
//  DoggoHome
//
//  Created by Julien Segers on 15/09/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: AddViewModel = .sharedInstance
    
    @State var selectedTab = "Home"
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                
    //            ForEach(viewModel.dogs) { dog in
    //                CardView(dog: dog)
    //                Text(dog.name)
    //            }
                
                CardView(dog: Dog(name: "blabla", race: "", age: 2, gender: "", sterile: true, pictureURL: "", location: "", dogFriendly: true, catFriendly: true, childFriendly: true, needsGarden: true, isClean: true))
                CardView(dog: Dog(name: "blabla", race: "", age: 2, gender: "", sterile: true, pictureURL: "", location: "", dogFriendly: true, catFriendly: true, childFriendly: true, needsGarden: true, isClean: true))
                CardView(dog: Dog(name: "blabla", race: "", age: 2, gender: "", sterile: true, pictureURL: "", location: "", dogFriendly: true, catFriendly: true, childFriendly: true, needsGarden: true, isClean: true))
                
            }
                        VStack {
                            Spacer()
                            CustomTapBar(selectedTab: $selectedTab)
                        }.edgesIgnoringSafeArea(.bottom)
            
            
            
        }
        
    }
    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
