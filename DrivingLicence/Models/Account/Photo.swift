//
//  Image.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 28.05.2023.
//

import Foundation
import RealmSwift
import UIKit

class Photo : Object , ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id : ObjectId
    @Persisted var thumbNail: Data?
    @Persisted var picture: Data?
    @Persisted var date = Date()
    
    convenience init(photoName: String) {
        self.init()
        self.thumbNail = (UIImage(named: photoName) ?? UIImage()).jpegData(compressionQuality: 0.8)
        self.picture = (UIImage(named: photoName) ?? UIImage()).jpegData(compressionQuality: 0.8)
        self.date = Date.now
    }
    
}
