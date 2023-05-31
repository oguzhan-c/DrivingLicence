//
//  CreateAccountDetailView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 12.04.2023.
//

import SwiftUI
import RealmSwift

struct CreateAccountDetailView: View {
    @ObservedResults(UserDetail.self) var userDetails
    @ObservedResults(Photo.self) var photos
    @ObservedResults(UserPreferences.self) var userPreferences
    @State private var newUserDetail = UserDetail()
   
    @Binding var user: User
    @Binding var isEditAccount : Bool
    @State private var displayName = ""
    @State private var photo: Photo?
    @State private var isPhotoAdded = false
    
    @State var userFirstName = ""
    @State var userLastName = ""
    @State var userEmail = ""
    @State var userPhoneNumber = ""
    @State var userType = ""
    @State var userDetailUpdateDate = Date()
    
    var body: some View {
            Form{
                Section(header: Text("User Profile")) {
                    TextField("User First Name" , text: $userFirstName)
                    TextField("userLastName" , text: $userLastName)
                    TextField("+90xxxxxxxxxx" ,text: $userPhoneNumber)
                    TextField("Display Name" , text : $displayName)
                    if let photo = photo{
                        AvatarButton(photo: photo) {
                            self.showPhotoTaker()
                        }
                    }
                    if photo == nil {
                        Button(action: { self.showPhotoTaker() }) {
                            Text("Add Photo")
                        }
                    }
                }
                
                Section{
                    Button(action: {
                        newUserDetail.owner_Id = user.id
                        newUserDetail.firstName = userFirstName
                        newUserDetail.lastName = userLastName
                        newUserDetail.email = user.profile.email!
                        newUserDetail.phoneNumber = userPhoneNumber
                        newUserDetail.userType = "Teacher"
                        newUserDetail.userDetailUpdateDate = Date.now
                        newUserDetail.presenceState = .onLine
                        saveUserPreference()
                        
                        $userDetails.append(newUserDetail)
                        
                        isEditAccount = false
                        
                    }){
                        HStack{
                            Spacer()
                            Text("Save")
                            Spacer()
                        }
                    }
                    Button(action : {
                        isEditAccount = false
                    }){
                        HStack{
                            Spacer()
                            Text("Cancel")
                            Spacer()
                        }
                    }
                }
            }
    }
    
    private func showPhotoTaker() {
        PhotoCaptureController.show(source: .photoLibrary) { controller, photo in
            self.photo = photo
            isPhotoAdded = true
            controller.hide()
            
            $photos.append(self.photo!)
        }
    }
    private func saveUserPreference(){
        let newUserPreferences = UserPreferences()
        newUserPreferences.displayName = displayName
        if isPhotoAdded {
            guard let newPhoto = photo else {
                print("Missing photo")
                return
            }
            newUserPreferences.avatarImage = newPhoto
        } else {
            newUserPreferences.avatarImage = Photo(photoName: "IMG_0005")
        }
        $userPreferences.append(newUserPreferences)
        
        newUserDetail.userPreferences = newUserPreferences
    }
}
