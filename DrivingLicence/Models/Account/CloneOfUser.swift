//
//  UserClone.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 28.05.2023.
//

import Foundation
import RealmSwift

class CloneOfUser :  Object , ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id : ObjectId
    @Persisted var userName : String
    @Persisted var displayName: String?
    @Persisted var avatarImage: Photo?
    @Persisted var lastSeenAt: Date?
    @Persisted var presence : String = "Off-Line"
    
    var presenceState: Presence {
        get { return Presence(rawValue: presence) ?? .hidden }
        set { presence = newValue.asString }
    }
}
