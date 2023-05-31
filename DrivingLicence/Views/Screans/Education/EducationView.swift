//
//  EducationView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 12.04.2023.
//

import SwiftUI
import RealmSwift

struct EducationView: View {
    
    @ObservedResults(Category.self) var category
    
    @State var user: User
    @State var isEditEducationCategory = false
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    if isEditEducationCategory{
                            CreateEducationCategory(isEditCategoryView: $isEditEducationCategory, user: $user)
                    }else{
                        EducationCategoryList(user: $user)
                    }
                }
                .navigationTitle("Education")
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        LogoutButton()
                    }
                    ToolbarItem(placement : .navigationBarTrailing){
                        NavigationLink("Account" , destination : AccountView(user: $user))
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

