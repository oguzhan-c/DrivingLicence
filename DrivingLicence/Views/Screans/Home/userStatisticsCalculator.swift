//
//  UserStatisticsCalculator.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 19.05.2023.
//

import SwiftUI
import RealmSwift

struct UserStatisticsCalculator: View {
    
    @ObservedResults(UserStatistic.self) var userStatistic
    @State var owner_Id = ""
    @State var TotalQuectionNumber : Int
    @State var CorrectQuectionNumber = 0
    @State var WrongQuectionNumber = 0
    @State var percentageOfCorrectAnswer = 0
    
    @Binding var user : User

    var body: some View {
        Text(user.profile.email!)
        
    }
}

