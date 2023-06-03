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
    @ObservedResults(CloneOfUser.self) var cloneOfUsers
    @State private var newUserDetail = UserDetail()
    @State private var newCloneOfUser = CloneOfUser()
    
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
                        DispatchQueue.main.async {
                            newUserDetail.firstName = userFirstName
                            newUserDetail.lastName = userLastName
                            newUserDetail.email = user.profile.email!
                            newUserDetail.phoneNumber = userPhoneNumber
                            newUserDetail.userType = "Teacher"
                            newUserDetail.userDetailUpdateDate = Date.now
                            newUserDetail.presenceState = .onLine
                            newUserDetail.owner_id = user.id
                           
                            saveUserPreference()
                            
                            $userDetails.append(newUserDetail)
                            saveCloneOfUser()
                            
                            isEditAccount = false
                        }
                        
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
        PhotoCaptureController.show(source: .photoLibrary) { controller, _photo in
            photo = _photo
            isPhotoAdded = true
            controller.hide()
        }
    }
    
    private func saveCloneOfUser(){
        newCloneOfUser.userName = user.profile.email!
        newCloneOfUser.owner_id = user.id
        newCloneOfUser.lastSeenAt = Date.now
        newCloneOfUser.presenceState = .onLine
        newCloneOfUser.displayName = displayName
        $cloneOfUsers.append(newCloneOfUser)
        print(cloneOfUsers.last!)
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
        newUserDetail.userPreferences = newUserPreferences
    }
}
