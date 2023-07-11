//
//  CreateQuection.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 12.05.2023.
//

import SwiftUI
import RealmSwift

struct CreateQuection: View {
    
    @ObservedResults(Quection.self) var quection
    @ObservedResults(Answer.self) var answers
    
    @State private var newquection = Quection()
    @State var quectionString = ""
    
    @Binding var isEditQuections : Bool
    @Binding var user : User
    
    @State private var newAnswer1 = Answer()
    @State private var newAnswer2 = Answer()
    @State private var newAnswer3 = Answer()
    @State private var newAnswer4 = Answer()
    
    @State var answer1 = ""
    @State var answer2 = ""
    @State var answer3 = ""
    @State var answer4 = ""
    
    @State var isCorrect1 = false
    @State var isCorrect2 = false
    @State var isCorrect3 = false
    @State var isCorrect4 = false
    
    @Environment(\.realm) var realm
    
    var body: some View {
        Form{
            VStack{
                Section(header: Text("Quection")) {
                    TextField("New Quection" , text : $quectionString)
                }
                .frame(height: 30)
                Section(header : Text("Answer 1")){
                    HStack{
                        TextField("Answer 1" , text: $answer1)
                        Toggle(isOn: $isCorrect1) {
                            Text("")
                        }
                        .toggleStyle(.switch)
                    }
                }
                .frame(height: 30)
                Section(header : Text("Answer 2")){
                    HStack{
                        TextField("Answer 2" , text: $answer2)
                        Toggle(isOn: $isCorrect2) {
                            Text("")
                        }
                        .toggleStyle(.switch)
                    }
                }
                .frame(height: 30)
                Section(header : Text("Answer 3")){
                    HStack{
                        TextField("Answer 3" , text: $answer3)
                        Toggle(isOn: $isCorrect3) {
                            Text("")
                        }
                        .toggleStyle(.switch)
                    }
                }
                .frame(height: 30)
                Section(header : Text("Answer 4")){
                    HStack{
                        TextField("Answer 4" , text: $answer4)
                        Toggle(isOn: $isCorrect4) {
                            Text("")
                        }
                        .toggleStyle(.switch)
                    }
                }
                .frame(height: 30)
            }
            Section{
                Button(action : {
                    newquection.quectionString = quectionString
                    user = app.currentUser!
                    
                    $quection.append(newquection)

                    newAnswer1.isCorrect = isCorrect1
                    newAnswer2.isCorrect = isCorrect2
                    newAnswer3.isCorrect = isCorrect3
                    newAnswer4.isCorrect = isCorrect4
                    
                    newAnswer1.answerString = answer1
                    newAnswer2.answerString = answer2
                    newAnswer3.answerString = answer3
                    newAnswer4.answerString = answer4
                    
                    newAnswer1.quectionId = newquection._id
                    newAnswer2.quectionId = newquection._id
                    newAnswer3.quectionId = newquection._id
                    newAnswer4.quectionId = newquection._id
                    
                    $answers.append(newAnswer1)
                    $answers.append(newAnswer2)
                    $answers.append(newAnswer3)
                    $answers.append(newAnswer4)
                    isEditQuections = false
                    
                }) {
                    HStack{
                        Spacer()
                        Text("Save")
                        Spacer()
                    }
                }
                Button(action: {
                    isEditQuections = false
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
        .onAppear(perform: setAnswerSubscription)
    }
    
    private func setSubscription() {
        let subscriptions = realm.subscriptions
        subscriptions.update {
            if let currentSubscription = subscriptions.first(named: "Quection") {
                currentSubscription.updateQuery(toType: Quection.self) {
                    $0.quectionString != ""
                }

            } else {
                subscriptions.append(QuerySubscription<Quection>(name: "Quection") {
                    $0.quectionString != ""
                })
            }
        }
    }
    
    private func setAnswerSubscription(){
        let subscriptions = realm.subscriptions
        subscriptions.update {
            if let currentSubscription = subscriptions.first(named: "Answer"){
                currentSubscription.updateQuery(toType: Answer.self){
                    $0.answerString != ""
                }
            }
            else{
                subscriptions.append(QuerySubscription<Answer>(name: "Answer"){
                    $0.answerString != ""
                })
            }
        }
    }
}
