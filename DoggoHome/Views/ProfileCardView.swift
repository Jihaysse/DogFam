//
//  ProfileCardView.swift
//  DoggoHome
//
//  Created by Julien Segers on 06/10/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileCardView: View {
    
    //MARK: - Properties
    
    var dog: Dog
    let colors = MyColors()
    
    //MARK: - View
    
    var body: some View {
        ZStack {
            if dog.gender == "Male" {
                colors.gradientBlue
                    .cornerRadius(15)
                    .shadow(radius: 10)
            } else {
                colors.gradientPink
                    .cornerRadius(15)
                    .shadow(radius: 10)
            }
            VStack {
                HStack(spacing: 0) {
                    WebImage(url: URL(string: dog.pictureURL))
                        .resizable()
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .padding(.leading)
                    Spacer()
                    VStack(alignment: .center) {
                        Text(dog.name)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        
                        if dog.age > 1 {
                            Text("\(dog.age) ans")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.bottom, 8)
                        } else if dog.age == 1 {
                            Text("\(dog.age) an")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.bottom, 8)
                        } else {
                            Text("Chiot")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.bottom, 8)
                        }
                            
                        Text(dog.race)
                            .font(.title)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }.padding(.trailing)
                    Spacer()
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.2)
    }
}

//struct ProfileCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileCardView(dog: Dog(userID: "", name: "Pepere", race: "Bouledogue Francais", age: 5, gender: "Male", sterile: true, pictureURL: "", shelter: nil, address: "", phoneNumber: "", dogFriendly: true, catFriendly: true, childFriendly: true, needsGarden: true, isClean: true))
//    }
//}
