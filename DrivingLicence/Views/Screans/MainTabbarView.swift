//
//  MainTabbarView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 23.03.2023.
//

import SwiftUI
import RealmSwift
struct MainTabbarView: View {
    var body: some View {
        if let user = app.currentUser {//send user to another screans
            TabView{
                HomeView(user: user)
                    .tabItem{
                        Image(systemName: "house")
                        Text("Home")
                    }
                EducationView(user: user)
                    .tabItem{
                        Image(systemName: "book")
                        Text("Education")
                    }
                QuectionsView(user: user)
                    .tabItem{
                        Image(systemName: "pencil")
                        Text("Quection")
                    }
                ChatView(user: user)
                    .tabItem{
                        Image(systemName: "bubble.left.fill")
                        Text("Chat")
             
                    }
            }
        }
        else{
            LoginView()
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabbarView()
//    }
//}
