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
    
    @State var user: User
    @State var isEditCarEducationTutorial = false
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    if isEditCarEducationTutorial{
                        CreateCarEducationCategory(isEditCarEducationTutorial: $isEditCarEducationTutorial, user: $user)
                    }else{
                        CarEducationTutorialList(user: $user)
                    }
                }
                .navigationTitle("Education")
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        LogoutButton()
                    }
                    ToolbarItem(placement : .navigationBarTrailing){
                        NavigationLink("Account" , destination : AccountView(user: user))
                    }
                    ToolbarItem(placement: .bottomBar) {
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
}
