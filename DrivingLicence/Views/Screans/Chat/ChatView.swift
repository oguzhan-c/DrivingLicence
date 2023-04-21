//
//  ChatView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 23.03.2023.
//

import SwiftUI
import RealmSwift

struct ChatView: View {
    
    @State var user: User

    
    var body: some View {
        NavigationView{
            ZStack{
                Color.cyan
            }
            .navigationTitle("Chat View")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    LogoutButton()
                }
                ToolbarItem(placement : .navigationBarTrailing){
                    NavigationLink("Account" , destination : AccountView(user : user))
                }
            }
        }
    }
}

