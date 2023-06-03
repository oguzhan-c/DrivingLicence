//
//  EducationCategoryList.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 12.04.2023.
//

import SwiftUI
import RealmSwift

struct EducationCategoryList: View {
    
    @ObservedResults(Category.self) var categories
    @Binding var user : User
    @ObservedRealmObject var userDetail : UserDetail

    var body: some View {
        VStack{
            if categories.count == 0{
                Text("Create Categories First")
            }else{
                List{
                    ForEach(categories){ category in
                        EducationCategoryRow(category: category, user: $user, userDetail: userDetail)
                    }
                    .onDelete(perform: $categories.remove)
                }
                .listStyle(InsetListStyle())
            }
        }
    }
}
