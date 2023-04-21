//
//  QuectionsView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 22.03.2023.
//

import SwiftUI
import RealmSwift

struct QuectionsView: View {
    
    var leadingBarButton: AnyView?
    @State var user: User

    var body: some View {
        NavigationView{
            ZStack{
                Color.pink
            }
            .navigationTitle("Quections")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    LogoutButton()
                }
                ToolbarItem(placement : .navigationBarTrailing){
                    NavigationLink("Account" , destination : AccountView(user: user))
                }
            }
        }
    }
}
