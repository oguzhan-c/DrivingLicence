//
//  ChatMessage.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 28.05.2023.
//

import Foundation
import RealmSwift

class ChatMessage : Object , ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var _id : ObjectId
    @Persisted var conversationId : ObjectId
    @Persisted var author : String//userName
    @Persisted var text : String//current user Id
    @Persisted var image : Photo?//current user profil image
    @Persisted var time : Date//
    @Persisted var ownerId : String
    
    convenience init(author: String, ownerId: String, text: String, image: Photo?, location: [Double] = []) {
        self.init()
        self.author = author
        self.ownerId = ownerId
        self.text = text
        self.image = image ?? nil
    }
}
