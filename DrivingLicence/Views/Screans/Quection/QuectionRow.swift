//
//  QuectionRoew.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 12.05.2023.
//

import SwiftUI
import RealmSwift

struct QuectionRow: View {
    
    @ObservedResults(UserStatistic.self) var userStatistics
    @State private var newuserStatistic = UserStatistic()
    
    //Allow us to go back quection list
    @Environment(\.presentationMode) var presentationMode
    
    @State var quection = Quection()
    @ObservedResults(Answer.self) var answers
    @State var whichChoice = ""
    @Binding var user : User
    
    @Environment(\.realm) var realm
    
    var body: some View {
        VStack{
            if let selectedAnswers = answers.filter("quectionId == %@" , quection._id){
                List{
                    Section{
                        Text(quection.quectionString)
                    }
                    .cornerRadius(5)
                    ForEach(selectedAnswers){ answer in
                        Section{
                            Button(action : {
                                
                                saveUserStatistics(quectionString: quection.quectionString, answer: answer)
                                presentationMode.wrappedValue.dismiss()
                                
                            }
                            ) {
                                HStack{
                                    Text(answer.answerString)
                                }
                            }
                        }
                    }
                    .onDelete(perform: $answers.remove)
                    .onAppear(perform: setSubscription)
                }
            }
            else{
                Text("Quection Does Not Exist")
                //add Alert Later
            }
        }
    }
    
    
    private func setSubscription() {
        let subscriptions = realm.subscriptions
        subscriptions.update {
            if let currentSubscription = subscriptions.first(named: "UserStatistic") {
                currentSubscription.updateQuery(toType: UserStatistic.self) {
                    $0.owner_id == user.id
                }

            } else {
                subscriptions.append(QuerySubscription<UserStatistic>(name: "UserStatistic") {
                    $0.owner_id == user.id
                })
            }
        }
    }
    private func saveUserStatistics(quectionString : String , answer : Answer ){
        let realm = try! Realm()
        
        
        if userStatistics.isEmpty{
            if answer.isCorrect{
                newuserStatistic.CorrectQuectionNumber += 1
            }
            else{
                newuserStatistic.WrongQuectionNumber += 1
            }
            newuserStatistic.TotalQuectionNumber  += 1
            newuserStatistic.owner_id = user.id
            newuserStatistic.percentageOfCorrectAnswer =
            Double((newuserStatistic.CorrectQuectionNumber/newuserStatistic.TotalQuectionNumber)*100)
            newuserStatistic.date = Date()
            $userStatistics.append(newuserStatistic)
        }
        else{
            if let lastObject = userStatistics.last{
                if user.id == lastObject.owner_id{
                    newuserStatistic.TotalQuectionNumber = lastObject.TotalQuectionNumber + 1
                    
                    if answer.isCorrect{
                        newuserStatistic.percentageOfCorrectAnswer = Double(((lastObject.CorrectQuectionNumber + 1)/newuserStatistic.TotalQuectionNumber)*100)
                        newuserStatistic.CorrectQuectionNumber = lastObject.CorrectQuectionNumber + 1
                        newuserStatistic.WrongQuectionNumber = lastObject.WrongQuectionNumber
                        print("true")
                    }
                    else{
                        newuserStatistic.percentageOfCorrectAnswer = Double((lastObject.CorrectQuectionNumber/newuserStatistic.TotalQuectionNumber)*100)
                        newuserStatistic.WrongQuectionNumber = lastObject.WrongQuectionNumber + 1
                        newuserStatistic.CorrectQuectionNumber = lastObject.CorrectQuectionNumber
                        print("false")

                    }
                    newuserStatistic.owner_id = user.id
                    newuserStatistic.date = Date()
                    $userStatistics.append(newuserStatistic)}  
            }
            else{
                print("There is not last object")
            }
        }
    }
}

