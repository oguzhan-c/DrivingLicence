//
//  UserDetail.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 28.03.2023.
//

import Foundation
import RealmSwift

class UserDetail : Object , ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var _id : ObjectId
//    @Persisted var correctAnswers : Int
//    @Persisted var wrongAnswers : Int
    @Persisted var firstName : String
    @Persisted var lastName : String
    @Persisted var phoneNumber : String
    @Persisted var email : String
    @Persisted var owner_Id : String
    @Persisted var userType : String
    @Persisted var userDetailUpdateDate : Date
}

