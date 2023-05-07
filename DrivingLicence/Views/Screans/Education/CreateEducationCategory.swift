//
//  CreateEducationCategory.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 12.04.2023.
//

import SwiftUI
import RealmSwift

struct CreateEducationCategory: View {

    @ObservedResults(Category.self) var categories
    @State private var newCategory = Category()
    @Binding var isEditCategoryView : Bool
    @Binding var user : User
    @State var vehicleName = ""
    
    var body: some View {
        Form{
            Section(header: Text("Category Name")) {
                TextField("New Category" , text : $vehicleName)
            }
            Section{
                Button(action : {
                    newCategory.vehicleName = vehicleName
                    $categories.append(newCategory)
                    isEditCategoryView = false
                    user = app.currentUser!
                }) {
                    HStack{
                        Spacer()
                        Text("Save")
                        Spacer()
                    }
                }
                Button(action: {
                    isEditCategoryView = false
                }) {
                    HStack {
                        Spacer()
                        Text("Cancel")
                        Spacer()
                    }
                }
            }
        }
    }
}

//struct CreateEducationCategory_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateEducationCategory(isEditCategoryView: true , user: <#T##User#>)
//    }
//}
