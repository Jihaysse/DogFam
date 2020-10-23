//
//  RegisterView.swift
//  DoggoHome
//
//  Created by Julien Segers on 21/09/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import SwiftUI
import Firebase

struct RegisterView: View {
    
    @State private var color = Color.black.opacity(0.7)
    @State private var email = ""
    @State private var pass = ""
    @State private var repass = ""
    @State private var visible = false
    @State private var revisible = false
    @State private var name = ""
    @State private var surname = ""
    @State private var selectedShelter: Int = 0
    @Binding var showRegisterView: Bool
    @State private var alert = false
    @State private var error = ""
    var db = Firestore.firestore()
    let viewRouter: ViewRouter = .sharedInstance
    
    
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
                            
                            TextField("Prénom", text: self.$name)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 4).stroke(self.name != "" ? Color("darkBlue") : self.color,lineWidth: 2))
                                .padding(.top, 25)
                            
                            TextField("Nom", text: self.$surname)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 4).stroke(self.surname != "" ? Color("darkBlue") : self.color,lineWidth: 2))
                                .padding(.top, 25)
                            
                            Picker(selection: $selectedShelter, label: Text("Refuge")) {
                                ForEach(0 ..< shelters.count, id: \.self) {
                                    Text(shelters[$0]).tag($0)
                                }
                            }
                            TextField("Email", text: self.$email)
                                .autocapitalization(.none)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("darkBlue") : self.color,lineWidth: 2))
                                .padding(.top, 25)
                            
                            HStack(spacing: 15){
                                
                                VStack{
                                    
                                    if self.visible{
                                        
                                        TextField("Mot de passe", text: self.$pass)
                                            .autocapitalization(.none)
                                            .disableAutocorrection(true)
                                    }
                                    else{
                                        
                                        SecureField("Mot de passe", text: self.$pass)
                                            .autocapitalization(.none)
                                            .disableAutocorrection(true)
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
                            .padding(.top, 25)
                            
                            HStack(spacing: 15){
                                
                                VStack{
                                    
                                    if self.revisible{
                                        
                                        TextField("Confirmation de votre mot de passe", text: self.$repass)
                                            .autocapitalization(.none)
                                            .disableAutocorrection(true)
                                    }
                                    else{
                                        
                                        SecureField("Confirmation de votre mot de passe", text: self.$repass)
                                            .autocapitalization(.none)
                                            .disableAutocorrection(true)
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
                            .padding(.top, 25)
                            
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
//                    }
                    
                    Button(action: {
                        
                        self.showRegisterView.toggle()
                        
                    }) {
                        
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(Color("darkBlue"))
                    }
                    .padding()
                }
            }.edgesIgnoringSafeArea(.top)

            
            if self.alert{
                
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
//        .navigationBarBackButtonHidden(true)
    }
    
    
    
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
                    
                    viewRouter.currentView = "Home"
                    self.createUser()
                    
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
    func createUser() {
        
    }
    
    
}



//struct RegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterView()
//    }
//}
