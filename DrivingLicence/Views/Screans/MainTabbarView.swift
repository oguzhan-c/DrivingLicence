//
//  MainTabbarView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 23.03.2023.
//

import SwiftUI
import RealmSwift
struct MainTabbarView: View {
    @Binding var user : User
    @ObservedRealmObject var userDetail : UserDetail

    
    var body: some View {
        TabView{
            HomeView(user: user , userDetail: userDetail)
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            EducationView(userDetail: userDetail, user: user)
                .tabItem{
                    Image(systemName: "book")
                    Text("Education")
                }
            QuectionsView(user: user , userDetail: userDetail)
                .tabItem{
                    Image(systemName: "pencil")
                    Text("Quection")
                }
            ChatView(user: $user , userDetail: userDetail)
                .tabItem{
                    Image(systemName: "bubble.left.fill")
                    Text("Chat")
         
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabbarView()
//    }
//}
