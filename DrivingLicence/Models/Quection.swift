//
//  Quections.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 22.03.2023.
//

import Foundation
import RealmSwift

class Quection : Object , ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var _id : ObjectId
    @Persisted var quectionString : String
    @Persisted var answers : RealmSwift.List<Answer>
    @Persisted var userAnswer : String
    @Persisted var ownerId : ObjectId
}
