//
//  CreateConversation.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 3.06.2023.
//

import SwiftUI
import RealmSwift

struct CreateConversation: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var errorHandler : ErrorHandler
    @Binding var user : User
    @ObservedRealmObject var userDetail : UserDetail
    @ObservedResults(CloneOfUser.self) var cloneOfUsers
 
    @State private var name = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    TextField("Chat Name", text: $name)
                    Text("Add Mambers")
                    List{
                        ForEach(cloneOfUsers) { cloneOfUser in
                            Button(action: {addConversation(cloneOfUser)}) {
                                if cloneOfUser.owner_id == user.id{
                                    Text("")
                                }
                                else{
                                    Text(cloneOfUser.userName)
                                }
                            }
                        }
                    }
                    Divider()
                    Text("Members")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Save") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    private func addConversation(_ newMember: CloneOfUser) {
        let currentUser = cloneOfUsers.first(where: { $0.owner_id == user.id })!
        let conversation = Conversation()
        conversation.displayName = newMember.displayName!
        conversation.members.append(Member(userName: newMember.userName, state: .active))
        conversation.members.append(Member(userName: currentUser.userName, state: .active))
        conversation.subject = name
        $userDetail.conversations.append(conversation)
    }
    
}
