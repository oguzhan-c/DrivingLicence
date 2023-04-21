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

    var body: some View {
        NavigationLink(destination: EducationListView()){
            Text(category.vehicleName)
            Spacer()
        }
    }
}
//
//struct EducationCategoryRow_Previews: PreviewProvider {
//    static var previews: some View {
//        EducationCategoryRow()
//    }
//}
