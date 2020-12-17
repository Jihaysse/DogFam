//
//  AddView.swift
//  DoggoHome
//
//  Created by Julien Segers on 17/09/2020.
//  Copyright © 2020 Julien Segers. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct AddView: View {
    
    //MARK: - Properties
    
    @ObservedObject var viewModel: AddViewModel = .sharedInstance
    @Binding var isSheetPresented: Bool
    @State private var isShowingImagePicker = false
    @State private var myImage: UIImage = UIImage(named: "no-profile-photo")!
    @State private var pictureURL: String = ""
    @State private var name: String = ""
    @State private var age: Int = 1
    @State private var selectedRace: Int = 0
    @State private var isMixed: Bool = false
    @State private var selectedGender: Int = 0
    @State private var isSterile: Bool = false
    @State private var isDogFriendly: Bool = false
    @State private var isCatFriendly: Bool = false
    @State private var isChildFriendly: Bool = false
    @State private var needsGarden: Bool = false
    @State private var isClean: Bool = false
    @State private var shelterName: String = ""
    @State private var phoneNumber: String = ""
    @State private var country: String = ""
    @State private var area: String = ""
    var dogID = UUID().uuidString
    var db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    let imageStorage = ImageStorage()

    
    //MARK: - Actions
    
    private func uploadDogToFirestore() {
        db.collection("dogs").document(dogID).setData(["userID": currentUser?.uid ?? "",
                                                       "dogID": dogID,
                                                    "name": self.name,
                                                    "race": races[selectedRace],
                                                    "age": self.age,
                                                    "gender": genders[selectedGender],
                                                    "sterile": self.isSterile,
                                                    "pictureURL": self.pictureURL,
                                                    "location": self.shelterName,
                                                    "phoneNumber": self.phoneNumber,
                                                    "dogFriendly": self.isDogFriendly,
                                                    "catFriendly": self.isCatFriendly,
                                                    "childFriendly": self.isChildFriendly,
                                                    "needsGarden": self.needsGarden,
                                                    "isClean": self.isClean]) { error in
            if let err = error {
                print("Error adding document: \(err)")
            } else {
                print("Dog added")
            }
        }
    }
    
    
    private func addDogToUserProfile() {
        if let currUserUID = currentUser?.uid {
            db.collection("profiles").document(currUserUID).setData(["dogs uploaded": true], merge: true) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document succesfully written")
            }
        }

        }
    }
    
    
    private func publishDog() {
        if let currUserUID = currentUser?.uid {
            imageStorage.uploadDogImageToFirestore(dogID: dogID, image: myImage) {
                imageStorage.downloadDogImageFromFirestore(dogID: dogID) { url in
                    self.pictureURL = url
                    self.uploadDogToFirestore()
                }
            }
        }
    }
    
    //MARK: - View
    
    var body: some View {
        
        
        NavigationView {
            Form {
                VStack {
                    HStack(alignment: .center) {
                        Spacer()
                        Image(uiImage: myImage)
                            .resizable()
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 180, height: 180)
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
                }.listRowBackground(Color(UIColor.systemGroupedBackground))
                
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
                
                Section(header: Text("Contact")
                            .bold()
                        .font(.headline)
                        ) {
                    TextField("Nom du refuge", text: $shelterName)
                    TextField("Numéro de téléphone", text: $phoneNumber)
                }
                
                Button(action: {
                    self.publishDog()
                    self.isSheetPresented.toggle()
                }, label: {
                    HStack(spacing: 15) {
                        Spacer()
                        Text("Publier")
                            .fontWeight(.semibold)
                        Image(systemName: "paperplane")
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
                ).listRowBackground(Color(UIColor.systemGroupedBackground))
                .padding(.bottom, 48)

                

            }.background(Color.red)
            .navigationBarTitle("Ajouter un chien")
                //                .navigationBarHidden(true)
                .navigationBarItems(trailing:
                    Button("Publier") {
                        uploadDogToFirestore()
                        addDogToUserProfile()
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

