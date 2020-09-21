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
    
    //MARK: - View
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: .init(colors: [.init(red: 0.2, green: 0.7, blue: 1), .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .cornerRadius(15)
                .shadow(radius: 10)
            VStack {
                HStack(spacing: 10) {
                    Image("bergerallemand")
                        .resizable()
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .padding(.leading)
//                    Spacer()
                    VStack(alignment: .center) {
                        Text(dog.name)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        Text("\(dog.age) ans")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.bottom)
                        Text(dog.race)
                            .font(.title)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                }.padding(.bottom)
                HStack(spacing: 20) {
                    InfoText(text: "Chiens",
                             imageName: dog.dogFriendly == true ? "checkmark.circle.fill" : "xmark.circle.fill", iconColor: dog.dogFriendly == true ? .green : .red)
                    InfoText(text: "Chats", imageName: "xmark.circle.fill", iconColor: .red)
                    InfoText(text: "Enfants", imageName: "checkmark.circle.fill", iconColor: .green)
                }.padding(.horizontal, 28)
                HStack(spacing: 20) {
                    InfoText(text: "Jardin", imageName: "checkmark.circle.fill", iconColor: .green)
                    InfoText(text: "Propre", imageName: "checkmark.circle.fill", iconColor: .green)
                    InfoText(text: "Stérile", imageName: "xmark.circle.fill", iconColor: .red)
                }.padding(.horizontal, 28)
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.35)
    }
}

//#if DEBUG
//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
//#endif

//MARK: - Struct: InfoText


struct InfoText: View {
    
    let text: String
    let imageName: String
    let iconColor: Color
    
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 21))
                .foregroundColor(.white)
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .frame(width: 22, height: 22)
                .foregroundColor(iconColor)
        }
    }
}
