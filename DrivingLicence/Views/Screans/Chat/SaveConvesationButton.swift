//
//  SaveConvesationButton.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 2.06.2023.
//

import SwiftUI
import RealmSwift

struct SaveConversationButton: View {
    @EnvironmentObject var errorHandler :ErrorHandler
    
    @ObservedRealmObject var userDetail : UserDetail
    
    let name: String
    let members: [String]
    var done: () -> Void = { }
    
    var body: some View {
        Button(action: saveConversation) {
            Text("Save")
        }
    }
    
    private func saveConversation() {
        errorHandler.swiftError = nil
        let conversation = Conversation()
        conversation.displayName = name
        conversation.members.append(Member(userName: userDetail.email, state: .active))
        conversation.members.append(objectsIn: members.map { Member($0) })
        $userDetail.conversations.append(conversation)
        done()
    }
}
