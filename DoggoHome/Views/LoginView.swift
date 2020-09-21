//
//  LoginView.swift
//  DoggoHome
//
//  Created by Julien Segers on 21/09/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var pass = ""
    @State var rem = false
    @State var height : CGFloat = 0
    
    var body: some View{
        
        // now were going to adjust view when keyboard appears...
        // enabling scroll view based on height...
        
        // for phones having lesser screen size....
        // were enabling scroll view for all time....
        
        ScrollView(UIScreen.main.bounds.height < 750 ? .vertical : (self.height == 0 ? .init() : .vertical), showsIndicators: false) {
            ZStack{
                VStack{
                    HStack(alignment: .top, spacing: 0){
                        Image("LoginImage")
                            .resizable()
                    }
                    
                    // moving view to bottom of the image...
                    
                    VStack(alignment: .leading){
                        
                        Text("Connexion")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("E-mail")
                            .fontWeight(.bold)
                            .padding(.top, 20)
                        VStack{
                            TextField("", text: self.$email)
                            Rectangle()
                                .fill(self.email == "" ? Color.black.opacity(0.08) : Color("darkBlue"))
                                .frame(height: 3)
                        }
                        Text("Mot de passe")
                            .fontWeight(.bold)
                            .padding(.top, 20)
                        VStack{
                            SecureField("", text: self.$pass)
                            Rectangle()
                                .fill(self.pass == "" ? Color.black.opacity(0.08) : Color("darkBlue"))
                                .frame(height: 3)
                        }
                        HStack{
                            Spacer()
                            Button(action: {
                            }) {
                                Text("Mot de passe oublié?")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("darkBlue"))
                            }
                        }
                        .padding(.top)
                        .padding(.bottom, 10)
                        
                        
                    }
                    .foregroundColor(Color.black.opacity(0.7))
                    .padding()
                    .background(Color.white)
                    .overlay(Rectangle().stroke(Color.black.opacity(0.03), lineWidth: 1).shadow(radius: 4))
                    .padding(.horizontal)
                    .padding(.top, -80)
                    
                    // for overviewing the view....
                    
                    HStack{
                        
                        Button(action: {
                            
                            self.rem.toggle()
                            
                        }) {
                            
                            HStack(spacing: 10){
                                
                                ZStack{
                                    
                                    Circle()
                                        .stroke(LinearGradient(gradient: .init(colors: [Color("lightBlue"),Color("darkBlue")]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
                                        .frame(width: 20, height: 20)
                                    
                                    if self.rem{
                                        
                                        Circle()
                                            .fill(Color("darkBlue"))
                                            .frame(width: 10, height: 10)
                                    }
                                }
                                
                                Text("Se souvenir de moi")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black.opacity(0.7))
                            }
                        }
                        .padding(.leading, 10)
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            
                            Text("CONNEXION")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .padding(.horizontal, 35)
                                .background(LinearGradient(gradient: .init(colors: [Color("lightBlue"),Color("darkBlue")]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(5)
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal)
                    
                    HStack{
                        
                        Rectangle()
                            .fill(Color.black.opacity(0.05))
                            .frame(width: 100, height: 5)
                        
                        Text("Social Login")
                            .foregroundColor(Color.black.opacity(0.7))
                            .fontWeight(.bold)
                        
                        Rectangle()
                            .fill(Color.black.opacity(0.05))
                            .frame(width: 100, height: 5)
                    }
                    .padding(.top)
                    
                    //social login buttons...
                    
                    HStack(spacing: 20){
                        
                        Button(action: {
                            
                        }) {
                            
                            Image("google")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.white)
                                .frame(width: 35, height: 35)
                                .padding(8)
                                .background(Color.red)
                                .clipShape(Circle())
                            
                        }
                        
                        Button(action: {
                            
                        }) {
                            
                            Image("twitter")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.white)
                                .frame(width: 35, height: 35)
                                .padding(8)
                                .background(Color("darkBlue"))
                                .clipShape(Circle())
                            
                        }
                        
                        Button(action: {
                            
                        }) {
                            
                            Image("fb")
                                .renderingMode(.original)
                                // sice were not adding padding so size is 48...
                                .resizable()
                                .frame(width: 48, height: 48)
                            
                        }
                    }
                    .padding(.top)
                    
                    HStack{
                        
                        Text("Nouvel utilisateur?")
                            .foregroundColor(Color.black.opacity(0.7))
                            .fontWeight(.bold)
                        
                        Button(action: {
                            
                        }) {
                            
                            Text("S'inscrire")
                                .foregroundColor(Color("darkBlue"))
                                .fontWeight(.bold)
                        }
                    }
                    .padding(.top,20)
                    .padding(.bottom)
                    
                    Spacer()
                }
                
                // since all edges are ignored...
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                
            }
        }
        // moving view up...
        .padding(.bottom, self.height)
        .background(Color.black.opacity(0.03).edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) { (not) in
                
                let data = not.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
                
                let height = data.cgRectValue.height - (UIApplication.shared.windows.first?.safeAreaInsets.bottom)!
                
                self.height = height
                
                // removing outside safe aera height...
                print(height)
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) { (_) in
                
                print("hidden")
                
                self.height = 0
            }
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
