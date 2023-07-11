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
    @Persisted var conversationId : String
    @Persisted var author : String//userName
    @Persisted var text : String
    @Persisted var image : Photo?//current user profil image
    @Persisted var time : Date//
    @Persisted var owner_id : String//current user Id
    
    convenience init(author: String, ownerid: String, text: String, image: Photo?) {
        self.init()
        self.author = author
        self.owner_id = ownerid
        self.text = text
        self.image = image ?? nil
    }
}
