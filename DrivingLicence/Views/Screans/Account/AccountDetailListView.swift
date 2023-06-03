//
//  AccountDetailListView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 12.04.2023.
//

import SwiftUI
import RealmSwift

struct AccountDetailListView: View {
    @ObservedResults(UserDetail.self) var userDetails
    @Binding var user : User
    var body: some View {
        VStack{
            if let lastDetail = userDetails.last{
                        Text(lastDetail.firstName)
                        Text(lastDetail.lastName)
                        Text(lastDetail.email)
                        Text(lastDetail.phoneNumber)
                        Text(lastDetail.userType)
                        Text((lastDetail.userPreferences?.displayName)!)
                UserAvatarView(photo: (lastDetail.userPreferences?.avatarImage)!, online: true)
            }
            else{
                Text("Create Account Details First")
            }
        }
    }
}
