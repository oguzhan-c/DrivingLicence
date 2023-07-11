//
//  SaveConversationButton.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 12.06.2023.
//

import SwiftUI
import RealmSwift

struct SaveConversationButton: View {
    @Environment(\.realm) var realm
    @EnvironmentObject var errorHandler : ErrorHandler
    @ObservedRealmObject var userDetail : UserDetail
    @Binding var user : User
    
    let name : String
    let members : [String]
    var done : () -> Void = {}
    
    
    var body: some View {
        Button(action: saveConversation ){
            Text("Save")
        }
        .onAppear(perform: setSubscription)
    }
    
    private func setSubscription(){
        let subscriptions = realm.subscriptions
        subscriptions.update {
            if let currentSubscription = subscriptions.first(named: "UserDetail"){
                print("Replacing subscription for UserDetail")
                currentSubscription.updateQuery(toType: UserDetail.self) {
                    $0.owner_id == user.id
                }
            }
            else{
                print("Appending subscription for UserDetail")
                subscriptions.append(QuerySubscription<UserDetail>(name: "UserDetail") {
                    $0.owner_id == user.id
                })
            }
        }
    }
    
    private func saveConversation(){
        errorHandler.stringError = nil
        let conversation = Conversation()
        conversation.displayName = name
        conversation.members.append(Member(userName: userDetail.email, state: .active))
        conversation.members.append(objectsIn: members.map { Member($0) })
        $userDetail.conversations.append(conversation)
    }
}

