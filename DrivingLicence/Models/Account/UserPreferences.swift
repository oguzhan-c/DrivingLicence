//
//  UserPreferences.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 28.05.2023.
//

import Foundation
import RealmSwift

class UserPreferences: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var displayName: String?
    @Persisted var avatarImage: Photo?

    var isEmpty: Bool { displayName == nil || displayName == "" }
}
