//
//  Tutorial.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 28.03.2023.
//

import Foundation
import RealmSwift

class Tutorial : Object , ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var _id : ObjectId
    @Persisted var tutorialName : String
    @Persisted var tutorialurl : String
    @Persisted var summary : String
    @Persisted var owner_Id : String
    @Persisted var checkIfComplate : Bool
}
