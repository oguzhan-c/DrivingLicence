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
    
    @Environment(\.realm) var realm
    
    @State private var newUserDetail = UserDetail()

    
    @Binding var user: User
    @Binding var isEditAccount : Bool
    @State private var displayName = ""
    @State private var photo: Photo?
    @State private var isPhotoAdded = false
    @State private var goToHomeView = false

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
                            isEditAccount = false
                            let newcloneOfUser = CloneOfUser(userDetail: newUserDetail)
                            $cloneOfUsers.append(newcloneOfUser)
                            $userDetails.append(newUserDetail)

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
            .onAppear(perform: setSubscription)
            .onAppear(perform: setCloneOfUserSbscription)
    }
    private func setCloneOfUserSbscription(){
        let subscriptions = realm.subscriptions
        subscriptions.update {
            if let currentSubscription = subscriptions.first(named: "CloneOfUser"){
                print("Replacing subscription for CloneOfUser")
                currentSubscription.updateQuery(toType: CloneOfUser.self) {
                    $0.owner_id == user.id
                }
            }
            else{
                print("Appending subscription for CloneOfUser")
                subscriptions.append(QuerySubscription<CloneOfUser>(name: "CloneOfUser") {
                    $0.owner_id == user.id

                })
            }
        }
    }
    
    private func setSubscription(){
        let subscriptions = realm.subscriptions
        subscriptions.update {
            if let currentSubscription = subscriptions.first(named: "UserDetail"){
                print("Replacing subscription for UserDetail")
                currentSubscription.updateQuery(toType: UserDetail.self) {
                    $0.owner_id == user.id
                }
            }
            else{
                print("Appending subscription for UserDetail")
                subscriptions.append(QuerySubscription<UserDetail>(name: "UserDetail") {
                    $0.owner_id == user.id
                })
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
