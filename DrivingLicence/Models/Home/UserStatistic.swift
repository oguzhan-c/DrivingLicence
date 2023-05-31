//
//  UserStatistic.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 19.05.2023.
//

import Foundation
import RealmSwift

class UserStatistic : Object , ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var _id : ObjectId
    @Persisted var owner_Id : String
    @Persisted var TotalQuectionNumber : Double
    @Persisted var CorrectQuectionNumber : Double
    @Persisted var WrongQuectionNumber : Double
    @Persisted var percentageOfCorrectAnswer :Double
    @Persisted var date : Date
}
