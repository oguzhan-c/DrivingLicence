//
//  Conversation.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 28.05.2023.
//

import Foundation
import RealmSwift

class Conversation: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var id = UUID().uuidString
    @Persisted var displayName = ""
    @Persisted var unreadCount = 0
    @Persisted var members = List<Member>()
    @Persisted var subject : String?

}
