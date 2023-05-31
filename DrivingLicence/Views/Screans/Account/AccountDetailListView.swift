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
            }
            else{
                Text("Create Account Details First")
            }
        }
    }
}
//
//struct AccountDetailListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountDetailListView()
//    }
//}
