//
//  EducationCategoryRow.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 12.04.2023.
//

import SwiftUI
import RealmSwift

struct EducationCategoryRow: View {
    @ObservedRealmObject var category : Category
    @Binding var user : User
    @ObservedRealmObject var userDetail : UserDetail

    var body: some View {
        NavigationLink(destination: CarEducationVideoView(userDetail: userDetail, user: user)){
            HStack{
                Text(category.vehicleName)
                Image(systemName: "car")
                    .frame(width: 90 , height: 90)
                Spacer()
            }
        }
    }
}
