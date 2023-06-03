//
//  TextDate.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 3.06.2023.
//

import SwiftUI

struct TextDate: View {
    let date: Date
    
    private var isLessThanOneMinute: Bool { date.timeIntervalSinceNow > -60 }
    private var isLessThanOneDay: Bool { date.timeIntervalSinceNow > -60 * 60 * 24 }
    private var isLessThanOneWeek: Bool { date.timeIntervalSinceNow > -60 * 60 * 24 * 7}
    private var isLessThanOneYear: Bool { date.timeIntervalSinceNow > -60 * 60 * 24 * 365}
    
    var body: some View {
        if isLessThanOneMinute {
            Text(date.formatted(.dateTime.hour().minute().second()))
        } else {
            if isLessThanOneDay {
                Text(date.formatted(.dateTime.hour().minute()))
            } else {
                if isLessThanOneWeek {
                    Text(date.formatted(.dateTime.weekday(.wide).hour().minute()))
                } else {
                    if isLessThanOneYear {
                        Text(date.formatted(.dateTime.month().day()))
                    } else {
                        Text(date.formatted(.dateTime.year().month().day()))
                    }
                }
            }
        }
    }
}
