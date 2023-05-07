//
//  CreateCarEducationTutorial.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 7.05.2023.
//

import SwiftUI
import RealmSwift
import GoogleAPIClientForREST_YouTube

struct CreateCarEducationCategory: View {

    @ObservedResults(Tutorial.self) var tutorial
    @State private var newTutorial = Tutorial()
//    @Persisted var tutorialName : String-
//    @Persisted var tutorialurl : String-
//    @Persisted var summary : String
//    @Persisted var owner_Id : String-
//    @Persisted var checkIfComplate : Bool
    @Binding var isEditCarEducationTutorial : Bool
    @Binding var user : User
    @State var tutorialName = ""
//    @State var tutorialurl : String = ""
//    @State var summary : String = ""
    @State private var searchResults: [GTLRYouTube_SearchResult] = []
    private let youTubeAPI = YouTubeAPI()
    
    var body: some View {
        Form{
            Section(header: Text("Tutorial Name")) {
                TextField("New Tutorial" , text : $tutorialName)
            }
            Section{
                Button(action : {
                    newTutorial.tutorialName = tutorialName
                    newTutorial.owner_Id = user.id
                    $tutorial.append(newTutorial)
                    isEditCarEducationTutorial = false
                    
                }) {
                    HStack{
                        Spacer()
                        Text("Save")
                        Spacer()
                    }
                }
                Button(action: {
                    isEditCarEducationTutorial = false
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
