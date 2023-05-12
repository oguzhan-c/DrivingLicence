//
//  QuectionRoew.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 12.05.2023.
//

import SwiftUI
import RealmSwift

struct QuectionRow: View {

//    let answers : Results<Answer>
    @State var quection = Quection()
    @ObservedResults(Answer.self) var answers
    var body: some View {
        VStack{
            if let selectedAnswers = answers.filter("quectionId == %@" , quection._id){
                Text(quection.quectionString)
                ForEach(selectedAnswers){ answer in
                    Text(answer.answerString)
                }
            }
            else{
                Text("Quection Does Not Exist")
                //add Alert Later
            }
        }
    }
}

