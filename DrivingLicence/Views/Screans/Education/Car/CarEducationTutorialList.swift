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
                List{
                    ForEach(tutorials){ tutorial in
                        CarEducationVideoRow(tutorial: tutorial,id: Int(tutorial.id) , user: $user)
                        
                    }
                    .onDelete(perform: $tutorials.remove)
                }
                
            }else{
                List{
                    ForEach(tutorials){ tutorial in
                        CarEducationVideoRow(tutorial: tutorial,id: Int(tutorial.id), user : $user)
                        
                    }
                    .onDelete(perform: $tutorials.remove)
                }
                .listStyle(InsetListStyle())
            }
        }
    }
}


