//
//  CarEducationVideoView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 7.05.2023.
//

import SwiftUI
import RealmSwift

struct CarEducationVideoView: View {
    @ObservedResults(Tutorial.self) var tutorial
    @ObservedRealmObject var userDetail : UserDetail

    @State var user: User
    @State var isEditCarEducationTutorial = false
    
    var body: some View {
            ZStack{
                VStack{
                    if isEditCarEducationTutorial{
                        CreateCarEducationCategory(isEditCarEducationTutorial: $isEditCarEducationTutorial, user: $user)
                            .environment(\.realmConfiguration, user.flexibleSyncConfiguration())
                    }else{
                        CarEducationTutorialList(user: $user)
                    }
                }
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
                    ToolbarItem(placement: .automatic) {
                        Button{
                            isEditCarEducationTutorial = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
    }
}
