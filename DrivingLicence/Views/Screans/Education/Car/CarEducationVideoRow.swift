////
////  EducationVideoRow.swift
////  DrivingLicence
////
////  Created by Oğuzhan Can on 1.05.2023.
////
//
import SwiftUI
import RealmSwift

struct CarEducationVideoRow: View {
    let tutorial : Tutorial
    var id : Int
    @Binding var user : User
    var body: some View {
        NavigationLink(destination : CarEducationVideoDetail(user: $user, searchQuery: tutorial)){
            CaptionLabel(title: "Ders :\t\(id + 1)")
                .fontDesign(.monospaced)
            
        }
    }
}


