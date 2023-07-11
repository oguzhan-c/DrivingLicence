//
//  ChatRoomView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 6.06.2023.
//

import RealmSwift
import SwiftUI

struct ChatRoomView: View {
    @EnvironmentObject var state: AppState
    
    @ObservedRealmObject var userdetail : UserDetail
    @Binding var user : User
    var conversation: Conversation?
    
    let padding: CGFloat = 8
    
    var body: some View {
        VStack {
            if let conversation = conversation {
                    ChatRoomBubblesView(userDetail: userdetail, user: $user, conversation: conversation)
                    .environment(\.realmConfiguration, user.flexibleSyncConfiguration())
            }
            else{
                ConversationListView(user: $user, userDetail: userdetail)
            }
            Spacer()
        }
        .navigationBarTitle(conversation?.displayName ?? "Chat", displayMode: .inline)
        .padding(.horizontal, padding)
        .onAppear(perform: clearUnreadCount)
        .onDisappear(perform: clearUnreadCount)
    }
    
    private func clearUnreadCount() {
        if let conversationId = conversation?.id {
            if let conversationIndex = userdetail.conversations.firstIndex(where: { $0.id == conversationId }) {
                $userdetail.conversations[conversationIndex].unreadCount.wrappedValue = 0
            }
        }
    }
}
