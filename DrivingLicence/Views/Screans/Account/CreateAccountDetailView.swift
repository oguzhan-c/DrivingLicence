//
//  CreateAccountDetailView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 12.04.2023.
//

import SwiftUI
import RealmSwift

struct CreateAccountDetailView: View {
    @ObservedResults(UserDetail.self) var userDetail
    
    @State private var newUserDetail = UserDetail()
    @Binding var isEditUserDetail: Bool
    @State var user: User
    @State var userFirstName = ""
    @State var userLastName = ""
    @State var userEmail = ""
    @State var userPhoneNumber = ""
    @State var userType = ""
    @State var userDetailUpdateDate = Date()
    
    var body: some View {
        Form{
            Section(header: Text("First Name")) {
                TextField("User First Name" , text: $userFirstName)
            }
            
            Section(header: Text("Last Name")) {
                TextField("userLastName" , text: $userLastName)
            }
            
            Section(header: Text("Phone Number")) {
                TextField("+90xxxxxxxxxx",text: $userPhoneNumber)
            }
            
            
            Section{
                Button(action: {
                    newUserDetail.owner_Id = user.id
                    newUserDetail.firstName = userFirstName
                    newUserDetail.lastName = userLastName
                    newUserDetail.email = user.profile.email!
                    newUserDetail.phoneNumber = userPhoneNumber
                    newUserDetail.userType = "Student"
                    newUserDetail.userDetailUpdateDate = Date.now
                    $userDetail.append(newUserDetail)
                    isEditUserDetail = false
                    

                }){
                    HStack{
                        Spacer()
                        Text("Save")
                        Spacer()
                    }
                }
                Button(action : {
                    isEditUserDetail = false
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
}

//struct CreateAccountDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateAccountDetailView()
//    }
//}
