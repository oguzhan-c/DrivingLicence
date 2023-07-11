//
//  ChatView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 23.03.2023.
//

import SwiftUI
import RealmSwift

struct ChatView: View {
    
    @Binding var user: User
    @ObservedRealmObject var userDetail : UserDetail

    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    ConversationListView(user: $user, userDetail: userDetail)
                }
                .navigationTitle("ChatView")
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading) {
                        LogoutButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        ZStack{
                            ZStack{
                                UserAvatarView(photo: userDetail.userPreferences?.avatarImage, online: true)
                            }
                            NavigationLink("    ",destination: AccountView(user: $user))
                                .environment(\.realmConfiguration, user.flexibleSyncConfiguration())
                        }
                    }
                }
            }
        }
    }
}

