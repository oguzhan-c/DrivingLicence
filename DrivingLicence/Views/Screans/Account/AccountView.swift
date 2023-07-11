//
//  AccountView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 25.03.2023.
//

import SwiftUI
import RealmSwift

struct AccountView: View {
    @Binding var user: User
    @State var isEditAccount = false
        
    var body: some View {
        NavigationView{
            ZStack{
                if isEditAccount{
                    CreateAccountDetailView(user: $user, isEditAccount: $isEditAccount)
                        .environment(\.realmConfiguration, user.flexibleSyncConfiguration())
                }else{
                    AccountDetailListView(user: $user)
                }
        
            }
            .navigationTitle("Account View")
            .navigationBarItems(trailing: HStack{
                Button{
                    isEditAccount = true
                } label: {
                    Image(systemName: "plus")
                }
            })
        }        
    }
}
