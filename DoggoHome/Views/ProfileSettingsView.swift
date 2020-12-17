//
//  ProfileSettingsView.swift
//  DoggoHome
//
//  Created by Julien Segers on 12/10/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ProfileSettingsView: View {
    
    //MARK: - Properties
    
    @ObservedObject var viewModel: ProfileViewModel = .sharedInstance
    @ObservedObject var user: UserAuth = .sharedInstance
    @ObservedObject var viewRouter: ViewRouter = .sharedInstance
    let currentUser = Auth.auth().currentUser
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var reputation: Int = 0
    @State private var selectedShelter: String = ""
    @State private var imageURL = ""
    @State private var isShowingImagePicker = false
    @State private var myImage = UIImage()
    var db = Firestore.firestore()
    let imageStorage = ImageStorage()
    
    
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
                    
                    Button(action: {
                        self.isShowingImagePicker.toggle()
                    }, label: {
                        ZStack {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                            Image(systemName: "pencil.circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.init(red: 0.18, green: 0.20, blue: 0.35))
                        }
                        
                    }).sheet(isPresented: $isShowingImagePicker, onDismiss: {
                        imageStorage.uploadImageToFirestore(id: currentUser!.uid, image: myImage) {
                            imageStorage.downloadImageFromFirestore(id: currentUser!.uid) { url in
                                self.imageURL = url
                                viewModel.updateProfilePicture(uid: currentUser!.uid, newImgURL: self.imageURL)

                            }
                        }
                    }, content: {
                        ImagePickerView(isPresented: $isShowingImagePicker, selectedImage: $myImage)
                    })
                    .offset(x: 50, y: -43)
                    
                    Spacer()
                    
//                    Text("Prénom")
//                        .foregroundColor(.secondary)
//                        .fontWeight(.semibold)
//                        .font(.system(size: 18))
//                        .frame(width: 310, alignment: .leading)
//                    TextField(viewModel.firstName, text: $firstName)
//                        .padding(10)
//                        .font(Font.system(size: 16, weight: .medium))
//                        .foregroundColor(Color.black)
//                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.3))
//                        .padding(.bottom)
//                    Text("Nom")
//                        .foregroundColor(.secondary)
//                        .fontWeight(.semibold)
//                        .font(.system(size: 18))
//                        .frame(width: 310, alignment: .leading)
//                    TextField(viewModel.lastName, text: $lastName)
//                        .padding(10)
//                        .font(Font.system(size: 16, weight: .medium))
//                        .foregroundColor(Color.black)
//                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.3))
//                        .padding(.bottom)
//                    Text("Refuge")
//                        .foregroundColor(.secondary)
//                        .fontWeight(.semibold)
//                        .font(.system(size: 18))
//                        .frame(width: 310, alignment: .leading)
//                    Picker(selection: $selectedShelter, label: Text("Refuge")) {
//                        ForEach(0 ..< shelters.count, id: \.self) {
//                            Text(shelters[$0]).tag($0)
//                        }
//                    }.frame(height: 150)
                    Button(action: {
                        // TO DO
                    }, label: {
                        HStack(spacing: 15) {
                            Text("Modifier votre mot de passe")
                                .fontWeight(.semibold)
                            Image(systemName: "lock.fill")
                            
                        }.padding(17)
                        .font(.system(size: 20))
                        .background(Color.init(red: 0.18, green: 0.20, blue: 0.35))
                        .cornerRadius(25)
                        .foregroundColor(.init(red: 0.95, green: 0.95, blue: 0.95))
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.init(red: 0.18, green: 0.20, blue: 0.35))
                        )
                        .frame(width: 320)
                        
                    }
                    ).padding(.top)
                    .padding(.bottom, 5)
                    
                    //                    BUTTON POUR CHANGER NOM PRENOM
                    
                    //                    VStack {
                    //                        Button(action: {
                    //                            viewModel.updateProfileData(uid: currentUser!.uid, name: firstName, surname: lastName)
                    //
                    //                        }, label: {
                    //                            HStack(spacing: 15) {
                    //                                Text("Sauvegarder")
                    //                                    .fontWeight(.semibold)
                    //                                Image(systemName: "lock.fill")
                    //
                    //                            }.padding(17)
                    //                            .font(.system(size: 20))
                    //                            .background(Color.init(red: 0.18, green: 0.20, blue: 0.35))
                    //                            .cornerRadius(25)
                    //                            .foregroundColor(.init(red: 0.95, green: 0.95, blue: 0.95))
                    //                            .overlay(
                    //                                RoundedRectangle(cornerRadius: 25)
                    //                                    .stroke(Color.init(red: 0.18, green: 0.20, blue: 0.35))
                    //                            )
                    //                            .frame(width: 320)
                    //
                    //                        }
                    //                        ).padding(.top)
                    //                        .padding(.bottom, 5)
                    
                    Button(action: {
                        user.logOut()
                    }, label: {
                        HStack(spacing: 15) {
                            Spacer()
                            Text("Se déconnecter")
                                .fontWeight(.semibold)
                            Image(systemName: "power")
                            Spacer()
                            
                        }.padding(17)
                        .font(.system(size: 20))
                        .background(Color.white)
                        .cornerRadius(25)
                        .foregroundColor(Color.init(red: 0.9, green: 0.4, blue: 0.4))
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.init(red: 0.9, green: 0.4, blue: 0.4))
                        )
                        .frame(width: 320)
                    }
                    ).padding(.bottom, 48)
                }
                
                
                
                
                
            }.padding(.horizontal, 45)
            .onAppear(perform: {
                viewModel.fetchProfileImageURL(uid: currentUser!.uid)
                viewModel.fetchProfileData(uid: currentUser!.uid)
            })
            .navigationBarItems(leading: Button(action: {
                viewRouter.currentView = "Profile"
                
            }, label: {
                HStack {
                    Image(systemName: "arrow.left")
                        .imageScale(.large)
                        .foregroundColor(.init(white: 1, opacity: 0.6))
                    Text("Profil")
                        .font(.system(size: 24))
                        .bold()
                        .foregroundColor(.white)
                    
                    
                }
                
                
            }))
            .background(BackgroundProfileSettings())

        }
        
    }
    
}





struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView()
    }
}


//MARK: - Struct: BackgroundProfileSettings

struct BackgroundProfileSettings: View {
    
    let color = MyColors()
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                LinearGradient(gradient: Gradient(colors: [Color.init(red: 0.29, green: 0.54, blue: 0.66), Color.init(red: 0.34, green: 0.29, blue: 0.62)]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                    .mask(Rectangle()
                            .frame(width: geometry.size.width * 2)
                            .offset(x: geometry.size.width * 0 , y: geometry.size.height * -0.9))
            }
        }
    }
}
