//
//  ChatRoomBubblesView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 6.06.2023.
//


import SwiftUI
import RealmSwift

struct ChatRoomBubblesView: View {
    @EnvironmentObject var state: AppState
    @ObservedResults(ChatMessage.self, sortDescriptor: SortDescriptor(keyPath: "time", ascending: true)) var chats
    @Environment(\.realm) var realm
    
    @ObservedRealmObject var userDetail : UserDetail
    @Binding var user : User
    var conversation: Conversation?
    
    @State private var realmChatsNotificationToken: NotificationToken?
    @State private var latestChatId = ""
    
    @State private var counter = 0
    
    private enum Dimensions {
        static let padding: CGFloat = 8
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ScrollViewReader { (proxy: ScrollViewProxy) in
                    VStack {
                        ForEach(chats) { chatMessage in
                            if chatMessage.conversationId == conversation?.id{
                                ChatBubbleView(chatMessage: chatMessage,
                                               authorName: chatMessage.author != userDetail.email ? chatMessage.author : nil, user: $user)
                                .id(chatMessage._id)
                            }
                        }
                    }
                    .onAppear {
                        scrollToBottom()
                    }
                    .onChange(of: latestChatId) { target in
                        withAnimation {
                            proxy.scrollTo(target, anchor: .bottom)
                        }
                    }
                }
            }
            Spacer()
            ChatInputBox(userDetail: userDetail, user: $user , send: sendMessage , focusAction: scrollToBottom)
        }
        .navigationBarTitle(conversation?.displayName ?? "Chat", displayMode: .inline)
        .padding(.horizontal, Dimensions.padding)
        .onAppear { loadChatRoom() }
        .onDisappear { closeChatRoom() }
    }
    
    private func loadChatRoom() {
        scrollToBottom()
        setSubscription()
        realmChatsNotificationToken = chats.thaw()?.observe { _ in
            scrollToBottom()
        }
    }
    
    private func closeChatRoom() {
        clearSunscription()
        if let token = realmChatsNotificationToken {
            token.invalidate()
        }
    }
    
    private func sendMessage(chatMessage: ChatMessage) {
        guard let conversation = conversation else {
            print("comversation not set")
            return
        }
        chatMessage.conversationId = conversation.id
        $chats.append(chatMessage)
    }
    
    private func scrollToBottom() {
        if chats.last?._id != nil {
            latestChatId = String(describing: chats.last?._id)
        }
        else {
            latestChatId = ""
        }
    }
    
    private func setSubscription() {
        let subscriptions = realm.subscriptions
        subscriptions.update {
            if let conversation = conversation{
                if let currentSubscription = subscriptions.first(named: "ChatMessage") {
                    currentSubscription.updateQuery(toType: ChatMessage.self) {
                        $0.conversationId == conversation.id
                    }
                } else {
                    subscriptions.append(QuerySubscription<ChatMessage>(name: "ChatMessage") {
                        $0.conversationId == conversation.id
                    })
                }
            }
        }
    }
    
    private func clearSunscription() {
        print("Leaving room, clearing subscription")
        let subscriptions = realm.subscriptions
        subscriptions.update {
            subscriptions.remove(named: "ChatMessage")
        }
    }
}
