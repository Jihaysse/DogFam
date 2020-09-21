//
//  CustomTapBar.swift
//  DoggoHome
//
//  Created by Julien Segers on 20/09/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import SwiftUI

struct CustomTapBar: View {
    
    @Binding var selectedTab: String
    @State var isSheetPresented: Bool = false
    
    var body: some View {
      
        HStack {
            TabButton(title: "Home", selectedTab: $selectedTab)
            Spacer(minLength: 0)
            Button(action: {
                isSheetPresented.toggle()
            }) {
                Image("plus")
                    .renderingMode(.original)
                    .padding(.vertical)
                    .padding(.horizontal, 25)
                    .background(Color("orange"))
                    .cornerRadius(15)
            }.sheet(isPresented: $isSheetPresented, content: {
                AddView(isSheetPresented: $isSheetPresented)
            })
            Spacer(minLength: 0)
            TabButton(title: "Profile", selectedTab: $selectedTab)

        }
        .padding(.top)
        .padding(.horizontal, 22)
       .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
        .background(Color.white)
        .clipShape(CustomCorner(corners: [.topLeft,.topRight], size: 55))
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: -5)
    }
}

//struct CustomTapBar_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTapBar()
//    }
//}


//MARK: - Struct: TabButton

struct TabButton: View {
    
    var title: String
    @Binding var selectedTab: String
    
    var body: some View {
        
    Button(action: {
            selectedTab = title
    }) {
        HStack(spacing: 10){
            Image(title)
                .renderingMode(.template)
            Text(title)
        }
        .foregroundColor(selectedTab == title ? Color("yellow") : .gray)
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(Color("yellow").opacity(selectedTab == title ? 0.15 : 0))
        .clipShape(Capsule())
    }
    }
}


//MARK: - Struct: CustomCorner

struct CustomCorner : Shape {
    
    var corners : UIRectCorner
    var size : CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: size, height: size))
        
        return Path(path.cgPath)
    }
}
