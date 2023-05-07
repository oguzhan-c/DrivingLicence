//
//  CarEducationTutorialList.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 7.05.2023.
//

import SwiftUI
import RealmSwift

struct CarEducationTutorialList: View {
    @ObservedResults(Tutorial.self) var tutorials
    @Binding var user : User
    var body: some View {
        VStack{
            if tutorials.count == 0{
                Text("Create Categories First")
            }else{
                List{
                    ForEach(tutorials){ tutorial in
                        CarEducationVideoRow(tutorialName: tutorial.tutorialName , id: Int(tutorial.id))
                        
                    }
                    .onDelete(perform: $tutorials.remove)
                }
                .listStyle(InsetListStyle())
            }
        }
    }
}

//struct CarEducationTutorialList_Previews: PreviewProvider {
//    static var previews: some View {
//        CarEducationTutorialList()
//    }
//}
