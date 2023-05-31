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
//    @Persisted var correctAnswers : Int delete this from database 
//    @Persisted var wrongAnswers : Int delete this from database
    @Persisted var firstName : String
    @Persisted var lastName : String
    @Persisted var phoneNumber : String
    @Persisted var email : String
    @Persisted var owner_Id : String
    @Persisted var userType : String
    @Persisted var userDetailUpdateDate : Date
    @Persisted var userPreferences: UserPreferences?
    @Persisted var lastSeenAt: Date?
    @Persisted var conversations = RealmSwift.List<Conversation>()
    @Persisted var presence = "On-Line"

    var isProfileSet: Bool { !(userPreferences?.isEmpty ?? true) }
    var presenceState: Presence {
        get { return Presence(rawValue: presence) ?? .hidden }
        set { presence = newValue.asString }
    }
  
    
    convenience init(firstName: String, id: ObjectId) {
        self.init()
        _id = id
        self.firstName = firstName
        userPreferences = UserPreferences()
        userPreferences?.displayName = firstName
        presence = "On-Line"
    }
}

enum Presence: String {
    case onLine = "On-Line"
    case offLine = "Off-Line"
    case hidden = "Hidden"
    
    var asString: String {
        self.rawValue
    }
}


