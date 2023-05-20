//
//  UserStatisticsCalculator.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 19.05.2023.
//

import SwiftUI
import RealmSwift
import Charts


struct UserStatisticsCalculator: View {
    @ObservedResults(UserStatistic.self) var userStatistics
    @Binding var user : User
    
    var body: some View {
        Chart{
            ForEach(userStatistics){statistic in
                LineMark(x: .value("day", getDay(form: statistic.date)! , unit: .month),
                        y: .value("persentange", statistic.percentageOfCorrectAnswer)
                )
            }
        }
    }
    

    private func getDay(form date : Date)->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.timeStyle = .short
        let dateStirng = dateFormatter.string(from: date)
        
        return dateFormatter.date(from: dateStirng)
    }
}
