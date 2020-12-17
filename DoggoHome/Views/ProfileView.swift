//
//  ProfileView.swift
//  DoggoHome
//
//  Created by Julien Segers on 21/09/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ProfileView: View {
    
    //MARK: - Properties
    
    @ObservedObject var viewModel: ProfileViewModel = .sharedInstance
    @ObservedObject var addViewModel: AddViewModel = .sharedInstance
    @ObservedObject var viewRouter: ViewRouter = .sharedInstance
    let currentUser = Auth.auth().currentUser
    let user: UserAuth = .sharedInstance
    let storage = Storage.storage()
    let imageStorage = ImageStorage()
    var db = Firestore.firestore()

    @State private var myDogs = [Dog]()
    @State private var imageURL = ""
    
    //MARK: - View
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack {
                    
                    WebImage(url: URL(string: viewModel.imageURL))
                        .resizable()
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 180, height: 180)
                        .padding(.top, 100)
                    HStack {
                        Text(viewModel.firstName)
                            .font(.title)
                            .bold()
                            .opacity(0.9)
                        Text(viewModel.lastName)
                            .font(.title)
                            .bold()
                            .opacity(0.9)
                        
                    }
                    // Use a ForEach loop (otherwise you can't use .onDelete)
                    ScrollView {
                        VStack {
                            ForEach(addViewModel.dogs) { dog in
                                if dog.userID == currentUser?.uid {
                                    ProfileCardView(dog: dog)
                                        .onTapGesture {
                                            // TO DO : New view showing more dog info
                                            if let index = addViewModel.dogs.firstIndex(where: { $0.id == dog.id }) {
                                                addViewModel.dogs.remove(at: index)
                                                print(dog.id)
                                                addViewModel.removeDogFromFirestore(dogID: dog.id)
                                            }
//                                            addViewModel.dogs.remove
                                        }
//                                        .onLongPressGesture {
//                                            addViewModel.removeDog(at: dog)
//
//                                }

                            }
                            }
                        }.padding(.horizontal, 10) // padding so the CardView's shadow isn't cut off
                        .padding(.bottom, 70)
                        .padding(.top, 15)
                        
                    }
                    
                    
                    
                    
                    // perform delete here      .onDelete( )
                }.onAppear(perform: {
                    viewModel.fetchProfileImageURL(uid: currentUser!.uid)
                    viewModel.fetchProfileData(uid: currentUser!.uid)
                    self.fetchMyDogs()
                })
                .edgesIgnoringSafeArea(.top)
                .navigationBarItems(trailing:
                                        Button(action: {
                                            viewRouter.currentView = "ProfileSettings"
                                        }, label: {
                                            Image(systemName: "gearshape.fill")
                                                .foregroundColor(.white)
                                                .imageScale(.large)
                                        }))
                
                VStack {
                    Spacer()
                    CustomTapBar()
                }
                .edgesIgnoringSafeArea(.bottom)
            }.background(BackgroundProfileView())
            
            
        }
        
    }
    

    
    
    func fetchMyDogs() {
        // TO DO: ajouter les chiens dans Firestore dans le profil de l'utilisateur et ensuite les télécharger depuis Firestore
        ForEach(addViewModel.dogs) { dog in
            if dog.userID == currentUser?.uid {
                ProfileCardView(dog: dog)
            }
        }
    }
    
    
    
}


//MARK: - Struct: BackgroundProfileView

struct BackgroundProfileView: View {
    
    let color = MyColors()
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                color.gradientBlue
                    .mask(Circle()
                            .frame(width: geometry.size.width * 2)
                            .offset(x: geometry.size.width * 0 , y: geometry.size.height * -0.9))
            }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


