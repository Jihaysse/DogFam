//
//  AddView.swift
//  DoggoHome
//
//  Created by Julien Segers on 17/09/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import SwiftUI
//import Firebase

struct AddView: View {
    
    //MARK: - Properties
    
    @ObservedObject var viewModel: AddViewModel = .sharedInstance
    @Binding var isSheetPresented: Bool
    @State private var isShowingImagePicker = false
    @State var myImage = UIImage()
    @State var name: String = ""
    @State var age: Int = 1
    @State var selectedRace: Int = 0
    @State var isMixed: Bool = false
    @State var selectedGender: Int = 0
    @State var isSterile: Bool = false
    @State var isDogFriendly: Bool = false
    @State var isCatFriendly: Bool = false
    @State var isChildFriendly: Bool = false
    @State var needsGarden: Bool = false
    @State var isClean: Bool = false
    
    
    //MARK: - View
    
    var body: some View {
        
        
        NavigationView {
            Form {
                VStack {
                    HStack(alignment: .center) {
                        Spacer()
                        Image(uiImage: myImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 200, height: 200)
                            .shadow(radius: 3)
                            .overlay(Circle().stroke(Color.black, lineWidth: 2))
                        Spacer()
                    }
                    Button(action: {
                        self.isShowingImagePicker.toggle()
                    }, label: {
                        Text("Choisir une photo")
                            .font(.system(size: 20))
                    }).sheet(isPresented: $isShowingImagePicker, content: {
                        ImagePickerView(isPresented: self.$isShowingImagePicker, selectedImage: self.$myImage)
                    })
                }
                
                Section(header: Text("Informations")
                    .bold()
                    .font(.title)) {
                    TextField("Nom", text: $name)
                        Stepper(value: $age, in: 0...20, label: {
                            if age > 1 {
                                Text("\(age) ans")
                            } else if age == 1 {
                                Text("\(age) an")
                            } else {
                                Text("Chiot")
                            }
                        })
                        Picker("", selection: $selectedGender) {
                            ForEach(0 ..< genders.count) {
                                Text(genders[$0]).tag($0).font(.title)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                        
                        Picker(selection: $selectedRace, label: Text("Race")) {
                            ForEach(0 ..< races.count, id: \.self) {
                                Text(races[$0]).tag($0)
                            }
                        }
                        Toggle("Croisé", isOn: $isMixed).toggleStyle(CheckmarkToggleStyle())
                        Toggle("Stérilisé", isOn: $isSterile).toggleStyle(CheckmarkToggleStyle())
                        }
                
                Section(header: Text("Comportement")
                            .bold()
                        .font(.headline)
                        ) {
                        Toggle("Propre", isOn: $isClean).toggleStyle(CheckmarkToggleStyle())
                        Toggle("Entente avec les chiens", isOn: $isDogFriendly).toggleStyle(CheckmarkToggleStyle())
                        Toggle("Entente avec les chats", isOn: $isCatFriendly).toggleStyle(CheckmarkToggleStyle())
                        Toggle("Entente avec les enfants", isOn: $isChildFriendly).toggleStyle(CheckmarkToggleStyle())
                        Toggle("Besoin d'un jardin", isOn: $needsGarden).toggleStyle(CheckmarkToggleStyle())
                        }

                

            }
            .navigationBarTitle("Ajouter un chien")
                //                .navigationBarHidden(true)
                .navigationBarItems(trailing:
                    Button("Publier") {
                        viewModel.dogs.append(Dog(name: self.name, race: races[selectedRace], age: self.age, gender: genders[selectedGender], sterile: self.isSterile, pictureURL: "", location: "", dogFriendly: self.isDogFriendly, catFriendly: self.isCatFriendly, childFriendly: self.isChildFriendly, needsGarden: self.needsGarden, isClean: self.isClean))
                        self.isSheetPresented.toggle()
                })
            
            
        }
        //        .edgesIgnoringSafeArea([.top])
        
    }
}

//struct AddView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddView()
//    }
//}


//MARK: - Struct: ImagePickerView

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Leave blank
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent: ImagePickerView
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImageFromPicker = info[.originalImage] as? UIImage {
                self.parent.selectedImage = selectedImageFromPicker
            }
            self.parent.isPresented = false
        }
    }
    
}



#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

