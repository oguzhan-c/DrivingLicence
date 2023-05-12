//
//  QuectionList.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 12.05.2023.
//

import SwiftUI
import RealmSwift

struct QuectionList: View {
    
    @ObservedResults(Quection.self) var quections
    @ObservedResults(Answer.self) var answers
    @Binding var user : User
    let temptQuection = ""
    var body: some View {
        VStack{
            if quections.count == 0{
                Text("Create quection First")
            }else{
                List{
                    ForEach(quections){ quection in
                        NavigationLink(destination: QuectionRow(quection: quection , answers: $answers)) {
                            Text("Quection :\t\(quection.id)")
                        }
                    }
                    .onDelete(perform: $quections.remove)
                    .onDelete(perform: $answers.remove)
                }
                .listStyle(InsetListStyle())
            }
        }
    }

}

