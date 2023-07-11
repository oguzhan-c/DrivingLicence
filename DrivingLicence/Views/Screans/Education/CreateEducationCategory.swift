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
    
    @Environment(\.realm) var realm
    
    var body: some View {
        Form{
            Section(header: Text("Category Name")) {
                TextField("New Category" , text : $vehicleName)
            }
            Section{
                Button(action : {
                    newCategory.vehicleName = vehicleName
                    newCategory.owner_id = user.id
                    $categories.append(newCategory)
                    isEditCategoryView = false
                }) {
                    HStack{
                        Spacer()
                        Text("Save")
                        Spacer()
                    }
                }
                .onAppear(perform: setSubscription)
                Button(action: {
                    isEditCategoryView = false
                }) {
                    HStack {
                        Spacer()
                        Text("Cancel")
                        Spacer()
                    }
                }
                .onAppear(perform: setSubscription)
            }
        }
    }
    
    private func setSubscription() {
        let subscriptions = realm.subscriptions
        subscriptions.update {
            if let currentSubscription = subscriptions.first(named: "Category") {
                currentSubscription.updateQuery(toType: Category.self) {
                    $0.vehicleName != ""
                }

            } else {
                subscriptions.append(QuerySubscription<Category>(name: "Category") {
                    $0.vehicleName != ""
                })
            }
        }
    }
    
}

//struct CreateEducationCategory_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateEducationCategory(isEditCategoryView: true , user: <#T##User#>)
//    }
//}
