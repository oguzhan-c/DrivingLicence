//
//  QuectionsView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 22.03.2023.
//

import SwiftUI
import RealmSwift

struct QuectionsView: View {
    @State var user: User
    @State var isEditQuections = false
 
    @ObservedRealmObject var userDetail : UserDetail

    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    if isEditQuections{
                        CreateQuection(isEditQuections: $isEditQuections, user: $user)
                        .environment(\.realmConfiguration, user.flexibleSyncConfiguration())                    }
                    else{
                        QuectionList(user: $user)
                    }
                }
                .navigationTitle("Quection")
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading) {
                        LogoutButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        ZStack{
                            ZStack{
                                UserAvatarView(photo: userDetail.userPreferences?.avatarImage, online: true)
                            }
                            NavigationLink("    ",destination: AccountView(user: $user))                                .environment(\.realmConfiguration, user.flexibleSyncConfiguration())

                        }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button{
                            isEditQuections = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
}
