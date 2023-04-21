//
//  Answers.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 22.03.2023.
//

import Foundation
import RealmSwift

class Answer : Object , ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var _id : ObjectId
    @Persisted var answerString : String
    @Persisted var isCorrect : Bool
}
