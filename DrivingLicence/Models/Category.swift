//
//  Category.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 23.03.2023.
//

import Foundation
import RealmSwift

class Category : Object , ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var _id : ObjectId
    @Persisted var vehicleName : String
}
