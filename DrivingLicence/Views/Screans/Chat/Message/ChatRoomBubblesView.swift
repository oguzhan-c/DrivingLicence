//
//  ChatRoomBubblesView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 3.06.2023.
//

import SwiftUI
import RealmSwift

struct ChatRoomBubblesView: View {
    @ObservedResults(ChatMessage.self, sortDescriptor: SortDescriptor(keyPath: "time", ascending: true)) var chats
    @Environment(\.realm) var realm

    @ObservedRealmObject var userDetail : UserDetail
    var conversation: Conversation?
    
    @State private var realmChatsNotificationToken: NotificationToken?
    @State private var latestChatId = ""
    
    private enum Dimensions {
        static let padding: CGFloat = 8
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ScrollViewReader { (proxy: ScrollViewProxy) in
                    VStack {
                        ForEach(chats) { chatMessage in
                            ChatBubbleView(chatMessage: chatMessage,
                                           authorName: userDetail.email)
                        }
                    }
                    .onAppear {
                        scrollToBottom()
                        withAnimation(.linear(duration: 0.2)) {
                            proxy.scrollTo(latestChatId, anchor: .bottom)
                        }
                    }
                    .onChange(of: latestChatId) { target in
                        withAnimation {
                            proxy.scrollTo(target, anchor: .bottom)
                        }
                    }
                }
            }
            Spacer()
            ChatInputBox(userDetail: userDetail, send: sendMessage, focusAction: scrollToBottom)
        }
        .navigationBarTitle(conversation?.displayName ?? "Chat", displayMode: .inline)
        .padding(.horizontal, Dimensions.padding)
        .onAppear { loadChatRoom() }
        .onDisappear { closeChatRoom() }
    }
    
    private func loadChatRoom() {
        setSubsCription()
    }
    private func setSubsCription(){
        let subscriptions = realm.subscriptions
        subscriptions.update {
            if let conversation = conversation{
                if let currentConversation = subscriptions.first(named: "conversation"){
                    currentConversation.updateQuery(toType: ChatMessage.self) { chatMessage in
                        chatMessage.conversationId == conversation.id
                    }
                }
                else{
                    subscriptions.append(QuerySubscription<ChatMessage>(name: "conversation"){
                        chatMessage in
                        chatMessage.conversationId == conversation.id
                    })
                }
            }
        }
    }
    private func closeChatRoom() {
        if let token = realmChatsNotificationToken {
            token.invalidate()
        }
    }
    
    private func sendMessage(chatMessage: ChatMessage) {
        guard let conversataionString = conversation else {
            print("comversation not set")
            return
        }
        chatMessage.conversationId = conversataionString.id
        $chats.append(chatMessage)
    }
    
    private func scrollToBottom() {
        latestChatId = String(describing: chats.last?.id)
    }
}
