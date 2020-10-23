//
//  CardView.swift
//  DoggoHome
//
//  Created by Julien Segers on 16/09/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
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
                Spacer()
                HStack(spacing: 10) {
                    Image("bergerallemand")
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
                                .padding(.bottom)
                        } else if dog.age == 1 {
                            Text("\(dog.age) an")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.bottom)
                        } else {
                            Text("Chiot")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.bottom)
                        }
                        Spacer()
                        Text(dog.race)
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            .minimumScaleFactor(0.4)
                            .lineLimit(1)
                            


                    }.fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                HStack(spacing: 20) {
                    InfoText(text: "Chiens",
                             imageName: dog.dogFriendly == true ? "checkmark.circle.fill" : "xmark.circle.fill", iconColor: dog.dogFriendly == true ? .green : .red)
                    InfoText(text: "Chats", imageName: dog.catFriendly == true ? "checkmark.circle.fill" : "xmark.circle.fill", iconColor: dog.catFriendly == true ? .green : .red)
                    InfoText(text: "Enfants", imageName: dog.childFriendly == true ? "checkmark.circle.fill" : "xmark.circle.fill", iconColor: dog.childFriendly == true ? .green : .red)
                }.padding(.horizontal, 28)
                HStack(spacing: 20) {
                    InfoText(text: "Jardin", imageName: dog.needsGarden == true ? "checkmark.circle.fill" : "xmark.circle.fill", iconColor: dog.needsGarden == true ? .green : .red)
                    InfoText(text: "Propre", imageName: dog.isClean == true ? "checkmark.circle.fill" : "xmark.circle.fill", iconColor: dog.isClean == true ? .green : .red)
                    InfoText(text: "Stérile", imageName: dog.sterile == true ? "checkmark.circle.fill" : "xmark.circle.fill", iconColor: dog.sterile == true ? .green : .red)
                }.padding(.horizontal, 28)
                
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.93, height: UIScreen.main.bounds.height * 0.30)
        .fixedSize()
        .padding(.bottom, 15)
    }
    
}

#if DEBUG
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(dog: Dog(userID: "", name: "Asuna", race: "Akita Americain", age: 2, gender: "Femelle", sterile: true, pictureURL: "", shelter: nil, address: "", phoneNumber: "", dogFriendly: true, catFriendly: false, childFriendly: true, needsGarden: true, isClean: true))
    }
}
#endif

//MARK: - Struct: InfoText


struct InfoText: View {
    
    let text: String
    let imageName: String
    let iconColor: Color
    
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 19))
                .foregroundColor(.white)
            Spacer()
            ZStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 21, height: 21)
                    .foregroundColor(.white)
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(iconColor)
            }
        }
    }
}
