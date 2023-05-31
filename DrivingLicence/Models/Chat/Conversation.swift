//
//  Conversation.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 28.05.2023.
//

import Foundation
import RealmSwift

class Conversation: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id : ObjectId
    @Persisted var displayName = ""
    @Persisted var unreadCount = 0
    @Persisted var members = List<Member>()
}
