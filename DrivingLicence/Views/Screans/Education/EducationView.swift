//
//  EducationView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 12.04.2023.
//

import SwiftUI
import RealmSwift

struct EducationView: View {
    @ObservedRealmObject var userDetail : UserDetail

    @ObservedResults(Category.self) var category
    
    @State var user: User
    @State var isEditEducationCategory = false
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    if isEditEducationCategory{
                            CreateEducationCategory(isEditCategoryView: $isEditEducationCategory, user: $user)
                            .environment(\.realmConfiguration, user.flexibleSyncConfiguration())
                    }else{
                        EducationCategoryList(user: $user, userDetail: userDetail)
                    }
                }
                .navigationTitle("Education")
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
                            isEditEducationCategory = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
}

