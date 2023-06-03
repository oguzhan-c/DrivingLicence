//
//  ConversationList.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 1.06.2023.
//
import SwiftUI
import RealmSwift

struct ConversationList: View {
    
    @ObservedRealmObject var userDetail : UserDetail
    @Binding var user : User
    var isPreview = false
    
    @State private var conversation: Conversation?
    @State private var showConversation = false
    @State private var showingAddChat = false
    
    private let sortDescriptors = [
        SortDescriptor(keyPath: "unreadCount", ascending: false),
        SortDescriptor(keyPath: "displayName", ascending: true)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if let conversations = userDetail.conversations.sorted(by: sortDescriptors) {
                        List {
                            ForEach(conversations) { conversation in
                                Button(action: {
                                    self.conversation = conversation
                                    showConversation.toggle()
                                }) {ConversationCardContentsView(conversation: conversation)
 }
                            }
                        }
                        Button(action: { showingAddChat.toggle() }) {
                            Text("New Chat Room")
                        }
                        .disabled(showingAddChat)
                    }
                    Spacer()
                    NavigationLink(
                        destination: ChatRoomView(userDetail: userDetail, conversation: conversation),
                        isActive: $showConversation) { EmptyView() }
                    
                    
                }
        }
        }
        .onAppear {
            $userDetail.presenceState.wrappedValue = .onLine
        }
        .sheet(isPresented: $showingAddChat) {
            
            CreateConversation(user: $user, userDetail: userDetail)
        }
    }
}
