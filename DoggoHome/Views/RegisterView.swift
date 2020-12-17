//
//  RegisterView.swift
//  DoggoHome
//
//  Created by Julien Segers on 21/09/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct RegisterView: View {
    
    
    //MARK: - Properties
    
    @State private var color = Color.black.opacity(0.7)
    @State private var email = ""
    @State private var pass = ""
    @State private var repass = ""
    @State private var visible = false
    @State private var revisible = false
    @State private var name = ""
    @State private var surname = ""
    @State private var isMember = false
    @State private var selectedShelter: Int = 0
    @Binding var showRegisterView: Bool
    @State private var alert = false
    @State private var error = ""
    @State private var isShowingImagePicker: Bool = false
    @State private var myImage: UIImage = UIImage(named: "no-profile-photo")!
    @State private var imageURL = ""
    
    
    var db = Firestore.firestore()
    let viewRouter: ViewRouter = .sharedInstance
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let storage = Storage.storage()
    let currentUser = Auth.auth().currentUser
    let imageStorage = ImageStorage()
    @State private var userUID = ""
    
    
    //MARK: - View
    
    var body: some View {
        
        ZStack {
            
            ScrollView {
                ZStack(alignment: .topLeading) {
                    
                    //                    GeometryReader{_ in
                    
                    VStack{
                        
                        //                        Image("logo")
                        
                        Text("Créer un compte")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(.top, 70)
                        
                        Image(uiImage: myImage)
                            .resizable()
                            .clipShape(Circle())
                            .shadow(radius: 5)
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
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.init(red: 0.18, green: 0.20, blue: 0.35))
                            }
                            
                        }).sheet(isPresented: $isShowingImagePicker, content: {
                            ImagePickerView(isPresented: self.$isShowingImagePicker, selectedImage: self.$myImage)
                        })
                        .offset(x: 50, y: -43)
                        
                        TextField("Prénom", text: self.$name)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.name != "" ? Color("darkBlue") : self.color,lineWidth: 2))
                            .padding(.top, 15)
                            .textContentType(.oneTimeCode)
                            .keyboardType(.default)
                        
                        TextField("Nom", text: self.$surname)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.surname != "" ? Color("darkBlue") : self.color,lineWidth: 2))
                            .padding(.top, 15)
                            .textContentType(.oneTimeCode)
                            .keyboardType(.default)
                        
                        
                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                            .padding()
                            .textContentType(.oneTimeCode)
                            .keyboardType(.default)                                .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("darkBlue") : self.color,lineWidth: 2))
                            .padding(.top, 15)
                        
                        HStack(spacing: 15){
                            
                            VStack{
                                
                                if self.visible{
                                    
                                    TextField("Mot de passe", text: self.$pass)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                        .textContentType(.oneTimeCode)
                                        .keyboardType(.default)
                                }
                                else{
                                    
                                    SecureField("Mot de passe", text: self.$pass)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                        .textContentType(.oneTimeCode)
                                        .keyboardType(.default)
                                }
                            }
                            
                            Button(action: {
                                
                                self.visible.toggle()
                                
                            }) {
                                
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                            
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("darkBlue") : self.color,lineWidth: 2))
                        .padding(.top, 15)
                        
                        HStack(spacing: 15){
                            
                            VStack{
                                
                                if self.revisible{
                                    
                                    TextField("Confirmation de votre mot de passe", text: self.$repass)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                        .textContentType(.oneTimeCode)
                                        .keyboardType(.default)
                                }
                                else{
                                    
                                    SecureField("Confirmation de votre mot de passe", text: self.$repass)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                        .textContentType(.oneTimeCode)
                                        .keyboardType(.default)
                                }
                            }
                            
                            Button(action: {
                                
                                self.revisible.toggle()
                                
                            }) {
                                
                                Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                            
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.repass != "" ? Color("darkBlue") : self.color,lineWidth: 2))
                        .padding(.top, 15)
                        
                        VStack {
                            Toggle("Êtes-vous membre d'un refuge?", isOn: $isMember).toggleStyle(CheckmarkToggleStyle())
                            
                            if isMember == true {
                                Picker(selection: $selectedShelter, label: Text("Refuge")) {
                                    ForEach(0 ..< shelters.count, id: \.self) {
                                        Text(shelters[$0]).tag($0)
                                    }
                                }
                            }
                        }
                        
                        
                        
                        Button(action: {
                            
                            self.register()
                            
                            
                        }) {
                            
                            Text("S'inscrire")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("darkBlue"))
                        .cornerRadius(10)
                        .padding(.top, 25)
                        
                    }
                    .padding(.horizontal, 25)
                    .navigationBarItems(leading:
                                            Button(action: {
                                                presentationMode.wrappedValue.dismiss()
                                            }, label: {
                                                Image(systemName: "chevron.left")
                                                    .font(.title)
                                                    .foregroundColor(Color("darkBlue"))
                                                Text("Retour")
                                                    .font(.headline)
                                                    .foregroundColor(Color("darkBlue"))
                                            }))
                    //                    }
                    
                    //                    Button(action: {
                    //
                    //                        self.showRegisterView.toggle()
                    //
                    //                    }) {
                    //
                    //                        Image(systemName: "chevron.left")
                    //                            .font(.title)
                    //                            .foregroundColor(Color("darkBlue"))
                    //                    }
                    //                    .padding()
                }
            }.edgesIgnoringSafeArea(.top)
            
            
            if self.alert{
                
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
    //MARK: - Actions
    
    func register() {
        if self.email != ""  {
            if self.pass == self.repass {
                Auth.auth().createUser(withEmail: self.email, password: self.pass) { (res, err) in
                    if err != nil {
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    // Success registering a new user
                    guard let userUID = res?.user.uid else { return }
                    viewRouter.currentView = "Home"
                    imageStorage.uploadImageToFirestore(id: userUID, image: myImage) {
                        imageStorage.downloadImageFromFirestore(id: userUID) { url in
                            self.imageURL = url
                            self.createUserDocument(id: userUID, imgURL: self.imageURL)
                            
                        }
                        
                        
                    }
                    //                    UserDefaults.standard.set(true, forKey: "status")
                    //                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }
                
            }
            else {
                self.error = "Les mots de passe ne correspondent pas"
                self.alert.toggle()
            }
        }
        else {
            self.error = "Veuillez remplir tous les champs"
            self.alert.toggle()
        }
    }
    
    
    // This function create a new user in the Cloud Firestore collection "users".
    func createUserDocument(id: String, imgURL: String) {
        db.collection("profiles").document(id).setData([
            "name": name,
            "surname": surname,
            "email": email,
            "shelter": isMember == true ? shelters[selectedShelter] : shelters[0],
            "photoURL": imgURL,
            "reputation": 0,
            "uuid": id
        ])
        { err in
            if let error = err {
                print("Error ading document: \(error)")
            } else {
                print("New profile document created in Firestore")
            }
        }
    }
    
    
    
    
    
}



//struct RegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterView()
//    }
//}


extension UIImage {
    func toString() -> String? {
        let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
