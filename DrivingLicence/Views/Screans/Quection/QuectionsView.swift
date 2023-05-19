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

    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    if isEditQuections{
                        CreateQuection(isEditQuections: $isEditQuections, user: $user)
                    }else{
                        QuectionList(user: $user)
                    }
                }
                .navigationTitle("Quection")
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        LogoutButton()
                    }
                    ToolbarItem(placement : .navigationBarTrailing){
                        NavigationLink("Account" , destination : AccountView(user: user))
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
