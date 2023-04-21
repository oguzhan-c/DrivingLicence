//
//  AccountView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 25.03.2023.
//

import SwiftUI
import RealmSwift

struct AccountView: View {
    @State var user: User
    @State var isEditUserDetail = false
    
    @ObservedResults(UserDetail.self) var userDetail
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.black
                if isEditUserDetail{
                    CreateAccountDetailView(isEditUserDetail: $isEditUserDetail, user: user)
                }else{
                    AccountDetailListView()
                }
        
            }
            .navigationTitle("Account View")
            .navigationBarItems(trailing: HStack{
                Button{
                    isEditUserDetail = true
                } label: {
                    Image(systemName: "plus")
                }
            })
        }
    }
}
    struct AccountView_Previews: PreviewProvider {
        static var previews: some View {
            AccountView(user: app.currentUser! , isEditUserDetail: false)
        }
    }
