//
//  QuectionRoew.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 12.05.2023.
//

import SwiftUI
import RealmSwift

struct QuectionRow: View {
    
    @ObservedResults(UserStatistic.self) var userStatistic
    @State private var newuserStatistic = UserStatistic()

    //Allow us to go back quection list
    @Environment(\.presentationMode) var presentationMode
    
    @State var quection = Quection()
    @ObservedResults(Answer.self) var answers
    @State var whichChoice = ""
    @Binding var user : User

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
                }
            }
            else{
                Text("Quection Does Not Exist")
                //add Alert Later
            }
        }
    }
    private func saveUserStatistics(quectionString : String , answer : Answer ){
        let realm = try! Realm()

        if userStatistic.isEmpty{
            if answer.isCorrect{
                newuserStatistic.CorrectQuectionNumber += 1
            }
            else{
                newuserStatistic.WrongQuectionNumber += 1
            }
            newuserStatistic.TotalQuectionNumber  += 1
            newuserStatistic.owner_Id = user.id
            newuserStatistic.percentageOfCorrectAnswer =
            Double((newuserStatistic.CorrectQuectionNumber/newuserStatistic.TotalQuectionNumber)*100)
            $userStatistic.append(newuserStatistic)
        }
        else{
            if let lastObject = userStatistic.last{
                if answer.isCorrect{
                    newuserStatistic.CorrectQuectionNumber = lastObject.CorrectQuectionNumber + 1
                    newuserStatistic.WrongQuectionNumber = lastObject.WrongQuectionNumber
                }
                else{
                    newuserStatistic.WrongQuectionNumber = lastObject.WrongQuectionNumber + 1
                    newuserStatistic.CorrectQuectionNumber = lastObject.CorrectQuectionNumber
                }
                newuserStatistic.TotalQuectionNumber = lastObject.TotalQuectionNumber + 1
                newuserStatistic.percentageOfCorrectAnswer =
                lastObject.percentageOfCorrectAnswer + ((newuserStatistic.CorrectQuectionNumber/newuserStatistic.TotalQuectionNumber)*100)
                newuserStatistic.owner_Id = user.id
                $userStatistic.append(newuserStatistic)
                $userStatistic.update()
            }
            else{
                print("There is not last object")
            }
        }
    }
}

