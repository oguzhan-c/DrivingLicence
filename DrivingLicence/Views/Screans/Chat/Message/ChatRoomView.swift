//
//  ChatRoomView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 1.06.2023.
//


import RealmSwift
import SwiftUI

struct ChatRoomView: View {
    
    @ObservedRealmObject var userDetail : UserDetail
    var conversation: Conversation?
    
    let padding: CGFloat = 8
    
    var body: some View {
        VStack {
            if let conversation = userDetail.conversations.first { _conversation in
                _conversation.id == conversation?.id
            } {
                ChatRoomBubblesView(userDetail: userDetail, conversation: conversation)
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
            if let conversationIndex = userDetail.conversations.firstIndex(where: { $0.id == conversationId }) {
                $userDetail.conversations[conversationIndex].unreadCount.wrappedValue = 0
            }
        }
    }
}
