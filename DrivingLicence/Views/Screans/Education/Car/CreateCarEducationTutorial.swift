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
    @Binding var isEditCarEducationTutorial : Bool
    @Binding var user : User
    @State var tutorialName = ""
    @State private var searchResults: [GTLRYouTube_SearchResult] = []
    
    @Environment(\.realm) var realm
    
    var body: some View {
        Form{
            Section(header: Text("Tutorial Name")) {
                TextField("New Tutorial" , text : $tutorialName)
            }
            Section{
                Button(action : {
                    newTutorial.tutorialName = tutorialName
                    newTutorial.owner_id = user.id
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
        .onAppear(perform: setSubscription)
    }
       
    
    private func setSubscription() {
        let subscriptions = realm.subscriptions
        subscriptions.update {
            if let currentSubscription = subscriptions.first(named: "Tutorial") {
                currentSubscription.updateQuery(toType: Tutorial.self) {
                    $0.owner_id == user.id
                }

            } else {
                subscriptions.append(QuerySubscription<Tutorial>(name: "Tutorial") {
                    $0.owner_id == user.id
                })
            }
        }
    }
}
